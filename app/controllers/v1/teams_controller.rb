module V1
  class TeamsController < V1::ApplicationController
    before_action :authenticate_user!, except: %i[index show]
    before_action :find_team, except: %i[create index]

    def create
      @team = Team.new
      @team.assign_attributes team_params
      authorize @team
      return unprocessable_entity @team unless @team.save
      render json: @team, status: :created
    end

    def destroy
      @team.destroy
      head :no_content
    end

    def index
      authorize Team
      scope = Team.all

      @teams = scope.page params[:page]
      render json: @teams
    end

    def show
      render json: @team
    end

    def update
      return unprocessable_entity @team unless @team.update_attributes team_params
      render json: @team
    end

    private

    def find_team
      @team = Team.find params[:id]
      authorize @team
    end

    def team_params
      params.require(:data).require(:attributes).permit policy(@team).permitted_attributes
    end

    include TeamsDoc
  end
end
