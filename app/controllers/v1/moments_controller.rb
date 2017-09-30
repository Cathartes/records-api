module V1
  class MomentsController < V1::ApplicationController
    def index
      authorize Moment
      scope = policy_scope Moment

      scope = scope.for_record_book params[:record_book_id] if params[:record_book_id].present?

      @moments = scope.page(client_page_number).per client_page_size
      render json: @moments, meta: render_pagination_meta(@moments)
    end

    include MomentsDoc
  end
end
