class User < ApplicationRecord
  has_secure_password validations: false

  has_many :authentication_tokens, dependent: :destroy
  has_many :participations, dependent: :destroy

  validates :admin, boolean: true
  validates :discord_name, length: { minimum: 6, maximum: 72 }, uniqueness: true
  validates :email, format: /\A[^@\s]+@[^@\s]+\z/, uniqueness: true, allow_nil: true
  validates :password, length: { minimum: 6, maximum: 72 }, if: proc { email.present? || password.present? }

  before_validation :set_password_updated_at, if: :password

  def find_token(token_body)
    authentication_tokens.detect do |token|
      ActiveSupport::SecurityUtils.secure_compare token.body, token_body
    end
  end

  private

  def set_password_updated_at
    self.password_updated_at = Time.now.utc
  end
end
