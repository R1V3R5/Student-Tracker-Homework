class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_location
  before_filter :find_course
  before_filter :find_assignment, only: [:show, :edit, :update, :destroy, :comment, :add_comment]


  def index
    authorize! :read, Assignment 
    @locations = Location.all
    @courses = @location.courses.all
    @assignments = @course.assignments.all
    respond_to do |format|
      format.html { redirect_to location_course_path(@location, @course) }
      format.json { render json: @assignments }
    end
  end


  def new
    authorize! :create, Assignment
    authorize! :read, Submission
    @locations = Location.all
    # @courses = @location.courses.all
    @assignment = Assignment.new
  end

  def create
    authorize! :create, Assignment 
    @assignment = @course.assignments.new assignment_params.merge(user_id: current_user.id)
    if @assignment.save
      flash[:notice] = "You have successfully created a new assignment"
      redirect_to location_course_assignment_path(@location, @course, @assignment)
      else
      flash[:error] = "You need to enter more information..."
      render :new
    end
  end

  def edit
    authorize! :update, Assignment
    @locations = Location.all
  end

  def update
    authorize! :update, Assignment
    @assignment.update_attributes assignment_params
    redirect_to location_courses_path(@location, @course)
  end

  def show
    authorize! :read, Assignment 
    authorize! :read, Submission
    @locations = Location.all 
    @courses = @location.courses.all
    @assignments = @course.assignments.all.accessible_by(current_ability, :read)
    @users = User.all.accessible_by(current_ability, :read)
    @submissions_incomplete = @assignment.submissions.where.not(workflow_state: "complete").accessible_by(current_ability, :read)
    @submissions_completed = @assignment.submissions.where(workflow_state: "complete")
    @comments = Comment.all
    @submissions = @assignment.submissions.all.accessible_by(current_ability, :read)
  end

  def destroy
    authorize! :destroy, Assignment 
    @assignment.delete
    redirect_to location_courses_path(@location, @course)
  end

  def comment
    # authorize! :update, 
    @comment = @assignment.comments.new
    respond_to do |format|
      format.js
    end
  end

  def add_comment
    @comment = @assignment.comments.create comment_params.merge(user_id: current_user.id, name: current_user.name)
    # redirect_to location_course_assignment_path(@location, @course, @assignment)
    respond_to do |format|
      format.js
    end
  end

private
  def assignment_params
    params.require(:assignment).permit(:name, :description, :course_id, :due_date)
  end

  def find_location
    @location = Location.find params[:location_id]
  end

  def find_course
    @course = @location.courses.find params[:course_id]
  end

  def find_assignment
    @assignment = @course.assignments.find params[:id]
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
