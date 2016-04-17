class UserMailer < ActionMailer::Base
  default from: 'notifications@movierama.com'

  def notification_email(email, name)
    @name = name
    mail(to: email, subject: 'Notification Email')
  end

end
