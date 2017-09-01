class User < ApplicationRecord
  attr_accessor :reset_password_redirect_url

  has_secure_password validations: false

  has_many :authentication_tokens, dependent: :destroy
  has_many :participations, dependent: :destroy

  validates :admin, boolean: true
  validates :discord_name, length: { minimum: 6, maximum: 72 }, uniqueness: true
  validates :email, format: /\A[^@\s]+@[^@\s]+\z/, uniqueness: true, allow_nil: true
  validates :password, length: { minimum: 6, maximum: 72 }, if: proc { password.present? || email.present? && email_was.nil? }

  before_validation :set_password_updated_at, if: :password

  def find_token(token_body)
    authentication_tokens.detect do |token|
      ActiveSupport::SecurityUtils.secure_compare token.body, token_body
    end
  end

  def send_reset_password_instructions!
    token = loop do
      token = SecureRandom.urlsafe_base64 nil, false
      break token unless self.class.exists? reset_password_token: token
    end

    update_attributes! reset_password_token: token, reset_password_sent_at: Time.now.utc
    AuthMailer.reset_password_instructions(self, reset_password_redirect_url).deliver
  end

  private

  def set_password_updated_at
    self.password_updated_at = Time.now.utc
  end
end
