module V1
  class UserSerializer < ApplicationSerializer
    attributes :admin, :confirmed_at, :confirmation_sent_at, :discord_name, :email, :membership_type, :password_updated_at,
               :reset_password_sent_at, :unconfirmed_email
  end
end
