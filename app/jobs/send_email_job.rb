class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(email, name)
    UserMailer.notification_email(email, name)
  end
end
