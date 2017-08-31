module V1
  module PasswordsDoc
    extend Apipie::DSL::Concern
    extend ApplicationDoc

    namespace 'v1'
    resource :passwords

    doc_for :create do
      api! 'Create a reset password request'
      json_api_wrap do
        param :email, String, 'Email tied to user to send password reset request to', required: true
        param :reset_password_redirect_url, String, 'URL to redirect the user to from the email request', required: true
      end
    end

    doc_for :update do
      api! 'Update a user password with a valid reset password token'
      json_api_wrap do
        param :password, String, 'New password to update the user', required: true
        param :reset_password_token, String, 'Unique token to validate password change', required: true
      end
    end
  end
end
