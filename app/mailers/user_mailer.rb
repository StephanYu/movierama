class UserMailer < ActionMailer::Base
  default from: 'notifications@movierama.com'

  def notification_email(user)
    @user = user
    mail(to: @user.email, subject: 'Notification Email')
    # mg_client = Mailgun::Client.new ENV['API_KEY']
    # message_params = {:from    => ENV['MAIL_USERNAME'],
    #   :to      => @user.email,
    #   :subject => 'Sample Mail using Mailgun API',
    #   :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
    #   mg_client.send_message ENV['DOMAIN'], message_params
  end

end
