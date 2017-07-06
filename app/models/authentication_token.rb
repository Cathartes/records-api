class AuthenticationToken < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  before_validation :generate_token, on: :create

  private

  def generate_token
    self.body = SecureRandom.urlsafe_base64 nil, false
  end
end
