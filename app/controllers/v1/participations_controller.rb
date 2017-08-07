module V1
  class ParticipationsController < V1::ApplicationController
    before_action :authenticate_user!, except: %i[index show]
    before_action :find_participation, except: %i[create index]

    def create
      @participation = Participation.new
      @participation.assign_attributes participation_params
      authorize @participation
      return unprocessable_entity @participation unless @participation.save
      render json: @participation, status: :created
    end

    def destroy
      @participation.destroy
      head :no_content
    end

    def index
      authorize Participation
      scope = Participation.all

      scope = scope.for_record_book params[:record_book_id] if params[:record_book_id].present?

      scope = scope.for_team params[:team_id] if params[:team_id].present?

      scope = scope.for_user params[:user_id] if params[:user_id].present?

      scope = case params[:participation_type]
              when 'member'
                scope.member
              when 'applicant'
                scope.applicant
              else
                scope
              end

      @participations = scope.page params[:page]
      render json: @participations
    end

    def show
      render json: @participation
    end

    def update
      return unprocessable_entity @participation unless @participation.update_attributes participation_params
      render json: @participation
    end

    private

    def find_participation
      @participation = Participation.find params[:id]
      authorize @participation
    end

    def participation_params
      params.require(:data).require(:attributes).permit policy(@participation).permitted_attributes
    end
  end
end