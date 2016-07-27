class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  has_many :user_subjects, dependent: :destroy

  after_create :create_user_subject
  after_create :send_mail_assign
  before_destroy :send_mail_delete

  private
  def create_user_subject
    UserSubject.transaction do
      begin
        course.subjects.each do |subject|
          user_subjects.create! user_id: user.id, subject_id: subject.id,
            user_course_id: self.id, course_id: course.id
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
