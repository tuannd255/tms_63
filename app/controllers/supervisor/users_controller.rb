class Supervisor::UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @user_courses = @user.user_courses.includes :course,
      user_subjects: [:subject]
  end
end
