module V1
  class RecordBooksController < V1::ApplicationController
    before_action :authenticate_user!, except: %i[index show]
    before_action :find_record_book, except: %i[create index]

    def create
      @record_book = RecordBook.new
      @record_book.assign_attributes user_params
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
      scope = RecordBook.all

      scope = current_user&.admin? && params[:unpublished].present? ? scope.unpublished : scope.published

      @record_books = scope.page params[:page]
      render json: @record_books
    end

    def show
      render json: @record_book
    end

    def update
      return unprocessable_entity @record_book unless @record_book.update_attributes user_params
      render json: @record_book
    end

    private

    def find_record_book
      @record_book = RecordBook.find params[:id]
      authorize @record_book
    end

    def user_params
      params.require(:data).require(:attributes).permit policy(@record_book).permitted_attributes
    end
  end
end
