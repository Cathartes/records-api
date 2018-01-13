# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'support@cathartes.blog'
  layout 'mailer'
end
