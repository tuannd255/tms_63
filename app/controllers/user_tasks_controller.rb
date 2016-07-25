class UserTasksController < ApplicationController
  load_and_authorize_resource

  def create
    if @user_task.save
      flash[:success] = t "admin.finish"
    else
      flash[:danger] = t "admin.update_fail"
    end
    redirect_to :back
  end

  private
  def user_task_params
    params.require(:user_task).permit :user_id, :task_id, :user_subject_id
  end
end
