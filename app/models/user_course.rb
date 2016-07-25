class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :user_subjects, dependent: :destroy

  after_create :create_user_subject

  private
  def create_user_subject
    UserSubject.transaction do
      begin
        course.subjects.each do |subject|
          user_subjects.create! user: user, subject: subject,
            user_course: self
        end
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end

  def send_mail_assign
    TraineeWorker.perform_async TraineeWorker::ASSIGN_TRAINEE,
      self.user_id, self.course_id
  end

  def send_mail_delete
    TraineeWorker.perform_async TraineeWorker::DELETE_TRAINEE,
      self.user_id, self.course_id
  end
end
