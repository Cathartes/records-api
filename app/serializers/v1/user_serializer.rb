module V1
  class UserSerializer < ApplicationSerializer
    attributes :admin, :confirmed_at, :confirmation_sent_at, :discord_name, :email, :reset_password_sent_at, :unconfirmed_email
  end
end
