class CoursesController < ApplicationController
  before_filter :find_location
  before_filter :find_course, only: [:show, :edit, :update, :destroy]

  def new
    authorize! :create, Course  
    @locations = Location.all
    @course = Course.new 

  end

  def index
    authorize! :read, Course
    @locations = Location.all
    @courses = @location.courses.accessible_by(current_ability, :read)
    respond_to do |format|
      format.html { redirect_to location_course_path(@location) }
    end

    # @assignments = @location.course.assignments.all
  end


  def create
  authorize! :create, Course
    @course = @location.courses.new course_params
    if @course.save
      flash[:notice] = "You have successfully created a new course"
      redirect_to location_path(@location)
      else
      flash[:error] = "You need to enter more information..."
      render :new
    end
  end

  def edit
    authorize! :update, Course
    @locations = Location.all
  end

  def update
    authorize! :update, Course
    @course.update_attributes course_params
    redirect_to location_path(@location)
  end

  def show
    authorize! :read, Course
    # @course = @location.courses.accessible_by(current_ability, :read)
    @locations = Location.all 
    @courses = @location.courses.all.accessible_by(current_ability, :read)
    
  end

  def destroy
    authorize! :destroy, Course
    @course.delete
    redirect_to location_path(@location)
  end

private
  def course_params
    params.require(:course).permit(:name, :description, :location_id)
  end

  def find_course
    @course = @location.courses.find params[:id]
  end
  def find_location
    @location = Location.find params[:location_id]
  end
end

