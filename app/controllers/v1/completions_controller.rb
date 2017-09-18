module V1
  class CompletionsController < V1::ApplicationController
    before_action :authenticate_user!, except: :index
    before_action :find_completion, except: %i[create index]

    def create
      @completion = Completion.new
      @completion.assign_attributes completion_params
      authorize @completion
      return unprocessable_entity @completion unless @completion.save
      render json: @completion, status: :created
    end

    def destroy
      @completion.destroy
      head :no_content
    end

    def index
      authorize Completion
      scope = policy_scope Completion

      scope = scope.for_participation params[:participation_id] if params[:participation_id].present?

      scope = scope.for_user params[:user_id] if params[:user_id].present?

      @completions = scope.page(client_page_number).per client_page_size
      render json: @completions, meta: render_pagination_meta(@completions)
    end

    def update
      return unprocessable_entity @completion unless @completion.update_attributes completion_params
      render json: @completion
    end

    private

    def completion_params
      params.require(:data).require(:attributes).permit policy(@completion).permitted_attributes
    end

    def find_completion
      @completion = Completion.find params[:id]
      authorize @completion
    end

    include CompletionsDoc
  end
end
