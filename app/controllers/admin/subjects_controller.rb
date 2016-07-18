class Admin::SubjectsController < ApplicationController
  load_and_authorize_resource

  def new
    Settings.default_number_of_tasks.times {@subject.tasks.build}
  end

  def create
    if @subject.save
      flash[:success] = t "subjects.created"
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  def index
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description,
      tasks_attributes: [:name, :description, :_destroy]
  end
end
