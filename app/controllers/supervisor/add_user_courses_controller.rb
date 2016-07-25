class Supervisor::AddUserCoursesController < ApplicationController
  load_and_authorize_resource :course

  def edit
    @users_in_course = @course.users
    @users = User.not_in_course(@course).trainee
    @users_not_in_course = @users.avaiable_user @course.id
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "admin.update_success"
      redirect_to supervisor_course_path @course
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
