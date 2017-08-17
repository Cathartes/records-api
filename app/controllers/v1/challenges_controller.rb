module V1
  class ChallengesController < V1::ApplicationController
    before_action :authenticate_user!, except: %i[index show]
    before_action :find_challenge, except: %i[create index]

    def create
      @challenge = Challenge.new
      @challenge.assign_attributes challenge_params
      authorize @challenge
      return unprocessable_entity @challenge unless @challenge.save
      render json: @challenge, status: :created
    end

    def destroy
      @challenge.destroy
      head :no_content
    end

    def index
      authorize Challenge
      scope = policy_scope Challenge

      scope = scope.for_record_book params[:record_book_id] if params[:record_book_id].present?

      @challenges = scope.page params[:page]
      render json: @challenges
    end

    def show
      render json: @challenge
    end

    def update
      return unprocessable_entity @challenge unless @challenge.update_attributes challenge_params
      render json: @challenge
    end

    private

    def challenge_params
      params.require(:data).require(:attributes).permit policy(@challenge).permitted_attributes
    end

    def find_challenge
      @challenge = Challenge.find params[:id]
      authorize @challenge
    end
  end
end
