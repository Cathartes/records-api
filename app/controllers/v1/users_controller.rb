module V1
  class UsersController < V1::ApplicationController
    before_action :authenticate_user!

    def create
      @user = User.new
      @user.assign_attributes user_params
      authorize @user
      return unprocessable_entity @user unless @user.save
      render json: @user, status: :created
    end

    def update
      @user = User.find params[:id]
      authorize @user
      return unprocessable_entity @user unless @user.update_attributes user_params
      render json: @user
    end

    private

    def user_params
      attrs = %i[discord_name email password]
      attrs << :admin if current_user&.admin?
      params.require(:data).require(:attributes).permit policy(@user).permitted_attributes
    end
  end
end
