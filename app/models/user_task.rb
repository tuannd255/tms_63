class UserTask < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  belongs_to :user_subject

  scope :my_task, -> id {where user_id: id}
end
