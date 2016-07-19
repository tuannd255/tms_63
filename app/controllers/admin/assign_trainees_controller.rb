class Admin::AssignTraineesController < ApplicationController
  load_and_authorize_resource :course

  def edit
    @user_courses = @course.user_courses
    @supervisors = User.supervisor
  end

  def update
    if @course.update_attributes user_course_params
      flash[:success] = t "successupdate"
      redirect_to admin_course_path @course
    else
      flash.now[:danger] = t "failupdate"
      redirect_to root_path
    end
  end

  private
  def user_course_params
    params.require(:course).permit user_ids: []
  end
end
