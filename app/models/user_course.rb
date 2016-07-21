class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :user_subjects, dependent: :destroy

  after_save :create_trainee_subject
  after_create :send_mail_assign
  before_destroy :send_mail_delete

  private
  def send_mail_assign
    TraineeWorker.perform_async TraineeWorker::ASSIGN_TRAINEE,
      self.user_id, self.course_id
  end

  def send_mail_delete
    TraineeWorker.perform_async TraineeWorker::DELETE_TRAINEE,
      self.user_id, self.course_id
  end

  def create_trainee_subject
    if self.course.course_subjects.any?
      UserSubject.transaction do
        begin
          self.course.course_subjects.each do |course_subject|
            course_subject.subject.user_subjects.create user: self.user,
              subject: course_subject.subject,
              user_course: self
          end
        rescue
          raise ActiveRecord::Rollback
        end
      end
    end
  end
end
