class LocationsController < ApplicationController
  before_action :authenticate_user!
  
  
  before_filter :find_location, only: [:show, :edit, :update, :destroy]

  def new
    authorize! :create, Location
    @locations = Location.all
    @location = Location.new 
  end

  def index
    authorize! :read, Location
    @locations = Location.accessible_by(current_ability)
    @locations = Location.all

  end


  def create
    authorize! :create, Location
    @location = Location.new location_params
    if @location.save
      flash[:notice] = "You have successfully created a new location"
      redirect_to locations_path
    else
      flash[:error] = "You need to enter more information to add this location"
      render :new
    end
  end

  def edit
    authorize! :update, Location
    @locations = Location.all
  end

  def update
    authorize! :update, Location
    @location.update_attributes location_params
    redirect_to locations_path
  end

  def show
    authorize! :read, Course
    @course = @location.courses.accessible_by(current_ability)
    @locations = Location.all    
  end

  def destroy
    authorize! :destroy, Location
    @location.delete
    redirect_to root_path
  end

private
  def location_params
    params.require(:location).permit(:name, :phone_number)
  end

  def find_location
    @location = Location.find params[:id]
  end

end
