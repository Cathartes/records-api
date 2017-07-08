module V1
  class SessionsController < V1::ApplicationController
    skip_after_action :verify_authorized

    def create
      return render_login_invalid if login_params[:email].blank?
      user = User.find_by email: login_params[:email]
      return render_login_invalid unless user&.authenticate login_params[:password]

      token = user.authentication_tokens.create!
      response.headers['X-USER-EMAIL'] = user.email
      response.headers['X-USER-TOKEN'] = token.body

      render json: user
    end

    def destroy
      current_user.find_token(request.headers['X-USER-TOKEN']).try(:destroy) if current_user.present?
      head :no_content
    end

    private

    def login_params
      params.require(:data).require(:attributes).permit %i[email password]
    end

    def render_login_invalid
      render json: {
        errors: [{
          title: 'Invalid credentials',
          detail: 'Your email or password was incorrect.'
        }]
      }, status: :unauthorized
    end
  end
end
