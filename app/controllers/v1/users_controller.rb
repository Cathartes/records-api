module V1
  class UsersController < V1::ApplicationController
    before_action :authenticate_user!, except: :index

    def create
      @user = User.new
      @user.assign_attributes user_params
      authorize @user
      return unprocessable_entity @user unless @user.save
      render json: @user, status: :created
    end

    def index
      authorize User
      scope = User.all

      scope = case params['membership_type']
              when 'applicant'
                scope.applicant
              when 'member'
                scope.member
              else
                scope
              end

      @users = scope.page(client_page_number).per client_page_size
      render json: @users, meta: render_pagination_meta(@users)
    end

    def update
      @user = User.find params[:id]
      authorize @user
      return unprocessable_entity @user unless @user.update_attributes user_params
      render json: @user
    end

    private

    def user_params
      params.require(:data).require(:attributes).permit policy(@user).permitted_attributes
    end

    include UsersDoc
  end
end
