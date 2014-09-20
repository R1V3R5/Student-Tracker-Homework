class SubmissionsController < ApplicationController
before_action :authenticate_user!
  before_filter :find_location
  before_filter :find_course
  before_filter :find_assignment
  before_filter :find_submission, only: [:show, :edit, :update, :destroy, :comment, :add_comment, :reviewing, :incomplete, :complete]

  def index
    # authorize! :read, Submission 
    respond_to do |format|
      format.json { render json: @submissions }
      format.html { redirect_to location_course_assignment_path(@location, @course, @assignment)}
    end
  end

  def new
    authorize! :create, Submission
    @submission = Submission.new
    @locations = Location.all
    @comments = @submission.comments.all
  end

  def create
    authorize! :create, Submission 
    @submission = @assignment.submissions.new submission_params.merge(user_id: current_user.id, name: current_user.name)
    if @submission.save
      flash[:notice] = "You have successfully submitted"
      redirect_to location_course_assignment_path(@location, @course, @assignment)
      else
      flash[:error] = "You need to enter more information..."
      render :new
    end
  end

  def edit
    authorize! :update, Submission
  end

  def update
    authorize! :update, Submission
    @submission.update_attributes submission_params
    redirect_to location_course_assignment_path(@location, @course, @assignment)
  end

  def show
    authorize! :read, Submission
    authorize! :read, Assignment 
    @assignments = @course.assignments.all
    @submissions = @assignment.submissions.all.accessible_by(current_ability, :read)
    @submissions_incomplete = @assignment.submissions.where.not(workflow_state: "complete").accessible_by(current_ability, :read)
    @submissions_completed = @assignment.submissions.where(workflow_state: "complete")
  end

  def destroy
    authorize! :destroy, Submission 
    @submission.delete
    redirect_to location_course_assignment_path(@location, @course, @assignment)    
  end

  def comment
    @comment = @submission.comments.new.accessible_by(current_ability, :read)
    respond_to do |format|
      format.js
    end
  end

  def add_comment
    @comment = @submission.comments.create comment_params.merge(user_id: current_user.id, name: current_user.name)
    respond_to do |format|
      format.js
    end
      # respond_to do |format|
      #   if @comment.save
      #     if current_user.is_admin?
      #       AdminMailer.new_comment_email(self).deliver
      #     elsif 
      #       UserMailer.new_comment_email(self).deliver
      #     end
      #     format.html { redirect_to location_course_assignment_submission_path(@location, @course, @assignment, @submission) , notice: 'Comment was successfully created.' }
      #   end
      # end
  end

  def reviewing
    authorize! :update, Submission
    @submission.reviewing!
    respond_to do |format|
      format.js
    end
  end

  def incomplete
    authorize! :update, Submission
    @submission.incomplete!
    respond_to do |format|
      format.js
    end
  end

  def complete
    authorize! :update, Submission
    @submission.complete!
    respond_to do |format|
      format.js
    end
  end

  def re_review
    authorize! :update, Submission
    @submission.re_review!
    respond_to do |format|
      format.js
    end
  end




private
  def submission_params
    params.require(:submission).permit(
      :assignment_id,
      :workflow_state,
      :title,
      links_attributes: [:id, :content, :submission_id, :_destroy]) 

  end

  def find_location
    @location = Location.find params[:location_id]
  end

  def find_course
    @course = @location.courses.find params[:course_id]
  end

  def find_assignment
    @assignment = @course.assignments.find params[:assignment_id]
  end

  def find_submission
    @submission = @assignment.submissions.find params[:id]
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
