class Supervisor::CoursesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :index
  
  def index
    @courses = Course.init.page params[:page]
  end

  def show
  end
end
