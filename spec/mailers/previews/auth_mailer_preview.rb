# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/auth_mailer
class AuthMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    AuthMailer.reset_password_instructions User.last, 'https://localhost:3000'
  end
end
