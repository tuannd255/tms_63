class Task < ActiveRecord::Base
  belongs_to :subject

  has_many :user_tasks, dependent: :destroy
  has_many :users, through: :user_tasks

  def my_task user_id, user_subject_id
    user_tasks.find_by user_id: user_id, task_id: self.id,
      user_subject_id: user_subject_id
  end
end
