module V1
  module PaginationHelpers
    DEFAULT_PAGE_SIZE = 25

    def client_page_number
      @page_number ||= params.dig :page, :number
    end

    def client_page_size(default: DEFAULT_PAGE_SIZE)
      @page_size ||= (params.dig(:page, :size) || default)
    end

    def render_pagination_meta(collection)
      {
        page: {
          number: params.dig(:page, :number) || 1,
          size: collection.limit_value,
          total: collection.total_count
        }
      }
    end
  end
end
