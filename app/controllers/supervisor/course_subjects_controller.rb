class Supervisor::CourseSubjectsController < ApplicationController
  load_and_authorize_resource

  def show
    @course = @course_subject.course
    @subject = @course_subject.subject
  end
end
