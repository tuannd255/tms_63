class Supervisor::CoursesController < ApplicationController
  load_and_authorize_resource
  skip_load_resource only: :show

  def index
    @courses = @courses.page params[:page]
  end

  def show
    @course = Course.includes(:users).find_by_id params[:id]
    @users_in_course = @course.users
  end
end
