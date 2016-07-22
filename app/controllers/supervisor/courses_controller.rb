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

  def update
    if @course.update_attributes course_params
      flash[:success] = t "supervisor.update_success"
      redirect_to supervisor_course_path @course
    else
      flash[:danger] = t "supervisor.update_fail"
      redirect_to supervisor_course_path
    end

  end

  private
  def course_params
    params.require(:course).permit :status 
  end
end
