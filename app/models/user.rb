# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  discord_name           :string           not null
#  password_digest        :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  admin                  :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_updated_at    :datetime
#  membership_type        :integer          default("applicant"), not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_discord_name          (discord_name) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  include Trackable

  attr_accessor :reset_password_redirect_url

  has_secure_password validations: false

  has_many :authentication_tokens, dependent: :destroy
  has_many :participations, dependent: :destroy

  has_one :active_participation, (lambda do
    joins(:record_book).where 'start_time <= :now AND end_time >= :now', now: Time.zone.now
  end), class_name: 'Participation'
  has_one :active_record_book, through: :active_participation, source: :record_book

  enum membership_type: { applicant: 0, member: 1 }

  validates :membership_type, presence: true
  validates :admin, boolean: true
  validates :discord_name, length: { minimum: 6, maximum: 72 }, uniqueness: true
  validates :email, format: /\A[^@\s]+@[^@\s]+\z/, uniqueness: true, allow_nil: true
  validates :password, length: { minimum: 6, maximum: 72 }, if: proc { password.present? || email.present? && email_was.nil? }

  before_validation :set_password_updated_at, if: :password

  scope :admin, (-> { where admin: true })

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

  def on_update_moment
    return unless membership_type_changed? && member? && active_record_book.present?
    build_moment moment_type: :new_member, record_book: active_record_book
  end

  def set_password_updated_at
    self.password_updated_at = Time.now.utc
  end
end
