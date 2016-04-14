require 'rails_helper'

Rspec.describe 'send email to user', type: :feature do
    # mailer functionality to test:
    # 1. Was it actually sending the email
    # 2. Was the email being sent to the desired recipient
    # 3. Was the subject line of the email correct
    # 4. Was the email being sent from the correct address

    before(:each) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []

      # use some form of Fabricator
      @user = Factory.create(:user)
      UserMailer.notification_email(@user).deliver
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it 'sends an email' do
      expect(ActionMailer::Base.deliveries.count).to eq 1
    end

    it 'renders the receiver email' do
      expect(ActionMailer::Base.deliveries.first).to eq @user.email
    end

    it 'sets the subject to the correct subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to eq 'Whatever the subject title is!'
    end

    it 'renders the sender email' do
      expect(ActionMailer::Base.deliveries.first.from).to eq['notifications@email.com']
    end
end
