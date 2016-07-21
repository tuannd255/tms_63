class UserTasksController < ApplicationController
  load_and_authorize_resource

  def update
    if @user_task.update_attributes user_task_params
      flash[:success] = t "admin.update_success"
    else
      flash[:danger] = t "admin.update_fail"
    end
    redirect_to :back
  end
  
  private
  def user_task_params
    params.require(:user_task).permit :status
  end
end
