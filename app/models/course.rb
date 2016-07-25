class Course < ActiveRecord::Base
  belongs_to :user

  has_many :user_courses, dependent: :destroy
  has_many :users, through: :user_courses
  has_many :course_subjects, dependent: :destroy
  has_many :subjects, through: :course_subjects

  validates :subjects, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :check_time

  accepts_nested_attributes_for :subjects, allow_destroy: true
  accepts_nested_attributes_for :user_courses, allow_destroy: true

  enum status: [:init, :start, :finish]

  def add_admin_to_course id
    self.update_attributes user_id: id
  end

  private
  def check_time
    if start_date > end_date
      errors.add :deadline, I18n.t("flash.not_valid_deadline")
    end
  end

  def schedule_mail_to_notify_finish_course
    SupervisorWorker.perform_at (end_date - 2.days),
      SupervisorWorker::NOTIFY_FINISH, self.id
  end
end
