class UserSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :user_course

  after_create :create_user_task

  has_many :user_tasks, dependent: :destroy

  private
  def create_user_task
    UserTask.transaction do
      begin
        subject.tasks.each do |task|
          user_tasks.create! user: user, task: task
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end
end
