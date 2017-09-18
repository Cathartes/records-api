# == Schema Information
#
# Table name: authentication_tokens
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  body       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_authentication_tokens_on_user_id  (user_id)
#

class AuthenticationToken < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  before_validation :generate_token, on: :create

  private

  def generate_token
    self.body = SecureRandom.urlsafe_base64 nil, false
  end
end
