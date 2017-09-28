module V1
  class RecordBooksController < V1::ApplicationController
    before_action :authenticate_user!, except: %i[index show]
    before_action :find_record_book, except: %i[create index]

    def create
      @record_book = RecordBook.new
      @record_book.assign_attributes record_book_params
      authorize @record_book
      return unprocessable_entity @record_book unless @record_book.save
      render json: @record_book, status: :created
    end

    def destroy
      @record_book.destroy
      head :no_content
    end

    def index
      authorize RecordBook
      scope = policy_scope RecordBook.includes(:participations, :teams)

      @record_books = scope.page(client_page_number).per client_page_size
      render json: @record_books, meta: render_pagination_meta(@record_books)
    end

    def show
      render json: @record_book
    end

    def update
      return unprocessable_entity @record_book unless @record_book.update_attributes record_book_params
      render json: @record_book
    end

    private

    def find_record_book
      @record_book = RecordBook.find params[:id]
      authorize @record_book
    end

    def record_book_params
      params.require(:data).require(:attributes).permit policy(@record_book).permitted_attributes
    end

    include RecordBooksDoc
  end
end
