class Supervisor::AddUserCoursesController < ApplicationController
  load_and_authorize_resource :course

  def edit
    @users_in_course = @course.users
    @users_not_in_course = User.not_in_course(@course).trainee
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "admin.update_success"
      redirect_to edit_supervisor_course_add_user_courses_path @course
    else
      flash[:danger] = t "admin.update_fail"
      render :edit
    end
  end

  private
  def course_params
    params.require(:course).permit user_ids: []
  end
end
