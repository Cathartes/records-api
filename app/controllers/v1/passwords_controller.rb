module V1
  class PasswordsController < V1::ApplicationController
    skip_after_action :verify_authorized

    def create
      user = User.find_by! email: password_create_params[:email]
      user.reset_password_redirect_url = password_create_params[:reset_password_redirect_url]
      user.send_reset_password_instructions
      head :no_content
    end

    def update
      user = User.find_by! reset_password_token: password_update_params[:reset_password_token]
      user.assign_attributes password_update_params.merge reset_password_token: nil
      return unprocessable_entity user unless user.save

      token = user.authentication_tokens.create!
      response.headers['X-USER-EMAIL'] = user.email
      response.headers['X-USER-TOKEN'] = token.body

      render json: user
    end

    private

    def password_create_params
      params.require(:data).require(:attributes).permit :email, :reset_password_redirect_url
    end

    def password_update_params
      params.require(:data).require(:attributes).permit :password, :reset_password_token
    end

    include PasswordsDoc
  end
end
