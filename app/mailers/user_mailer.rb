class UserMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]

  ["send_email_when_trainee_assigned", "send_email_when_trainee_removed"].
    each do |send_email|
    define_method send_email do |user, course|
      @user = user
      @course = course
      mail to: @user.email, subject: t("mail.#{send_email}",
        content: course.description)
    end
  end
end
