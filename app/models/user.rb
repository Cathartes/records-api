class User < ApplicationRecord
  has_secure_password

  has_many :authentication_tokens, dependent: :destroy
  has_many :participations, dependent: :destroy

  validates :admin, boolean: true
  validates :discord_name, length: { minimum: 6, maximum: 72 }, uniqueness: true
  validates :email, format: /\A[^@\s]+@[^@\s]+\z/, uniqueness: true, allow_nil: true
  validates :password, length: { minimum: 6, maximum: 72 }, on: :create
  validates :password, length: { minimum: 6, maximum: 72 }, if: :password, on: :update

  before_validation :generate_password, unless: :email

  def find_token(token_body)
    authentication_tokens.detect do |token|
      ActiveSupport::SecurityUtils.secure_compare token.body, token_body
    end
  end

  private

  def generate_password
    self.password ||= SecureRandom.hex 16
  end
end
