class Admin::UserCoursesController < ApplicationController
  load_and_authorize_resource

  def destroy
    course = @user_course.course
    if @user_course.destroy
      flash[:success] =  t "flash.removed_user"
    else
      flash.now[:danger] = t "flash.remove_user_failed"
    end
    redirect_to admin_course_path course
  end
end
