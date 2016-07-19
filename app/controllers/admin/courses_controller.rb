class Admin::CoursesController < ApplicationController
  load_and_authorize_resource
  before_action :load_subjects, only: [:edit, :new]

  def index
    @courses = @courses.page params[:page]
    @course = Course.new
  end

  def show
  end

  def new
  end

  def create
    if @course.save
      flash[:success] = t "admin.success"
      redirect_to admin_courses_path
    else
      load_subjects
      flash[:danger] = t "admin.create_fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = t "admin.update_success"
      redirect_to admin_courses_path
    else
      load_subjects
      flash[:danger] = t "admin.create_fail"
      render :edit
    end
  end

  def destroy
    if @course.destroy
      flash[:success] = t "admin.delete_success"
    else
      flash[:danger] = t "admin.delete_fail"
    end
    redirect_to admin_courses_path
  end

  private
  def course_params
    params.require(:course).permit :name, :description, :status, 
      subject_ids: []
  end

  def load_subjects
    @subjects = Subject.all
  end
end
