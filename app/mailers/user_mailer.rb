class UserMailer < ActionMailer::Base
  default from: 'notifications@movierama.com'

  def notification_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Someone has something to say about your movie! :)')
  end
end