class UserSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  belongs_to :user_course

  has_many :user_tasks, dependent: :destroy

  enum status: [:init, :start, :finish]

  def progress
    if self.user_tasks.any?
      Settings.progress * self.user_tasks.size / self.subject.tasks.size
    else
      return 0
    end
  end
end
