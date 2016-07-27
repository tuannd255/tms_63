class UserCoursesController < ApplicationController
  load_and_authorize_resource only: :show

  def index
    @user_courses = current_user.user_courses.includes(course: [:user])
  end

  def show
    @course = @user_course.course
    #@subjects = @course.subjects
    @subjects = @course.subjects.map do |subject|
      [subject, UserSubject.find_by(user_id: @user_course.user.id,
      subject_id: subject.id, course_id: @course.id),
      CourseSubject.find_by(course_id: @course.id, subject_id: subject.id)]
      end
  end
end
