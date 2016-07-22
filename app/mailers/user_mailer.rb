class UserMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]

  ["send_email_when_trainee_assigned", "send_email_when_trainee_removed"].
    each do |send_email|
    define_method send_email do |user, course|
      @user = user
      @course = course
      mail to: @user.email, subject: t("mail.#{send_email}",
        content: @course.name)
    end
  end

  def mail_month
    Course.all.each do |course|
      @admin = course.user
      @course = course
      mail to: @admin.email, subject: t("mail.month_info_corse",
        content: @course.name)
    end
  end

  def will_finish_in_two_days course
    @course = course
    @user = @course.user
    mail to: @user.email, subject: t("mail.will_finish",
      content: @course.name)
  end
end
