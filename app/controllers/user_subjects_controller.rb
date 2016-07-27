class UserSubjectsController < ApplicationController
  load_and_authorize_resource

  def show
    @user_course = @user_subject.user_course
    @course = @user_course.course
  end

  def update
    if @user_subject.update_attributes user_subject_params
      flash[:success] = t "admin.users.end_subject"
    else
      flash[:danger] = t "course_subjects.start_error"
    end
    redirect_to :back
  end

  private
  def user_subject_params
    params.require(:user_subject).permit :status
  end
end
