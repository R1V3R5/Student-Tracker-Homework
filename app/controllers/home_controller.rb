class HomeController < ApplicationController
before_action :authenticate_user!



  def index
    authorize! :read, Location
    @locations = Location.accessible_by(current_ability)
    @locations = Location.all 
  end

end
