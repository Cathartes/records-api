require 'rails_helper'

RSpec.describe AuthMailer, type: :mailer do
  describe '.reset_password_instructions' do
    let(:user) { create :user, :claimed }
    let(:mail) { described_class.reset_password_instructions(user, 'http://test.com').deliver_now }

    it 'is expected to render the subject' do
      expect(mail.subject).to eq I18n.t 'auth_mailer.reset_password_instructions.subject'
    end

    it 'is expected to set the receiver emails' do
      expect(mail.to).to include user.email
    end

    it 'is expected to set the sender emails' do
      expect(mail.from).to include 'support@cathartes.blog'
    end
  end
end
