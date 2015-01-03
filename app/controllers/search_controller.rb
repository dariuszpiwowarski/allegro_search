class SearchController < ApplicationController
  def index
    @categories = [['All',nil]]
    @categories += Category.where(parent: 0).order(:name).map {|c| [c.name, c.id]}
  end
  def search
    category_id = params[:category_id]
    query = params[:query]
    @order_by = params[:order_by] || "1" # end time is default
    @order_type = params[:order_type] || "0" # asc is default
    offset = params[:offset].to_i || 0

    allegro_api = AllegroApi.instance
    options = {}
    options[:search_category] = category_id unless category_id.blank?
    options[:search_order] = @order_by
    options[:search_order_type] = @order_type
    options[:search_offset] = offset
    options[:search_price_from] = params[:price_from] || 0
    options[:search_price_to] = params[:price_to] || 0
    
    begin
      @res = allegro_api.search(query, options)
    rescue
      render json: {error: "Search failed"}, status: 500
      return
    end

    # Normally [:do_search_response][:search_array][:item] is an array
    # But when there is only one resut the allegro's API doesn't return it
    # as an array. So to keep it consistent, we put it into an array.
    if (@res[:do_search_response][:search_count].to_i > 0) && (@res[:do_search_response][:search_array][:item].is_a? Hash)
      @res[:do_search_response][:search_array][:item] = [@res[:do_search_response][:search_array][:item]]
    end

    @prev_button = nil
    @next_button = nil
    search_count = @res[:do_search_response][:search_count].to_i
    search_limit = 50 # allegro returns 50 results per page by default
    if search_count > search_limit
      if search_limit * (offset + 1) < search_count
        @next_button = offset + 1
      end
      if offset > 0
        @prev_button = offset -1
      end
    end
    render layout: false
  end
end
