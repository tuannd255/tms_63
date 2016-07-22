class TraineeWorker
  include Sidekiq::Worker

  ASSIGN_TRAINEE = "assigned"
  DELETE_TRAINEE = "removed"

  def perform action, trainee_id, course_id
    send "send_email_when_trainee_#{action}", trainee_id, course_id
  end

  private
  ["send_email_when_trainee_assigned", "send_email_when_trainee_removed"].
    each do |send_email|
    define_method send_email do |trainee_id, course_id|
      trainee = User.find_by id: trainee_id
      course = Course.find_by id: course_id
      UserMailer.send("#{send_email}", trainee, course).deliver
    end
  end
end
