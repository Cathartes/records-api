# frozen_string_literal: true

class AuthMailer < ApplicationMailer
  def reset_password_instructions(user, redirect_url)
    @user         = user
    @redirect_url = redirect_url

    mail to: @user.email, subject: I18n.t('auth_mailer.reset_password_instructions.subject')
  end
end
