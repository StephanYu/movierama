require 'rails_helper'

RSpec.describe UserMailer do
  
  describe '#notification_email' do 
    before(:each) do
      ActionMailer::Base.delivery_method = :test
      ActionMailer::Base.perform_deliveries = true
      ActionMailer::Base.deliveries = []

      @user = User.create :name => "TestUser", :email => "test@email.com"
      UserMailer.notification_email(@user.email, @user.name).deliver
    end

    it 'sends an email' do
      expect(ActionMailer::Base.deliveries.count).to eq 1
    end

    it 'renders the receiver email' do
      expect(ActionMailer::Base.deliveries.first.to).to eq [@user.email]
    end

    it 'sets the subject to the correct subject' do
      expect(ActionMailer::Base.deliveries.first.subject).to eq 'Notification Email'
    end

    it 'renders the sender email' do
      expect(ActionMailer::Base.deliveries.first.from).to eq ['notifications@movierama.com']
    end
  end
end
