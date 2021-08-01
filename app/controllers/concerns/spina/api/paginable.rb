module Spina
  module Api
    module Paginable
      extend ActiveSupport::Concern
    
      private
      
        def pagination(records)
          paginated_records = records.page(params[:page]).per(params[:per_page])
          [paginated_records, {
            meta: pagination_meta(paginated_records),
            links: pagination_links(paginated_records)
          }]
        end
        
        def pagination_meta(paginated_records)
          {
            current_page: paginated_records.current_page,
            total: paginated_records.total_count,
            per_page: paginated_records.limit_value,
            path: view_context.url_for(only_path: true)
          }
        end
        
        def pagination_links(paginated_records)
          {
            first: path_to_first_page,
            prev: view_context.path_to_prev_page(paginated_records),
            next: view_context.path_to_next_page(paginated_records),
            last: path_to_last_page(paginated_records)
          }
        end
        
        def path_to_first_page
          view_context.url_for(page: 1, per_page: params[:per_page], only_path: true)
        end
        
        def path_to_last_page(paginated_records)
          view_context.url_for(page: paginated_records.total_pages, per_page: params[:per_page], only_path: true)
        end
          
    end
  end
end