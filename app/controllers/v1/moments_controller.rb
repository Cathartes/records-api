module V1
  class MomentsController < V1::ApplicationController
    def index
      authorize Moment
      scope = policy_scope Moment.includes parse_includes default_includes

      scope = scope.for_record_book params[:record_book_id] if params[:record_book_id].present?

      scope = scope.order :created_at
      @moments = scope.page(client_page_number).per client_page_size
      render json: @moments, meta: render_pagination_meta(@moments), include: params[:include]
    end

    private

    def default_includes
      %i[trackable]
    end

    include MomentsDoc
  end
end
