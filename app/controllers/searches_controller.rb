class SearchesController < ApplicationController
  def index
    if params[:term]
      @results = Github::Search.new.repositories(search_params)
      set_pagination_configuration
    else
      @results = []
    end
  end

  private

  def search_params
    params.permit(:term, :sort_by, :per_page, :page).to_h.symbolize_keys
  end

  def set_pagination_configuration
    @pagy = Pagy.new(count: github_max_results, page: search_params[:page])
  end

  def github_max_results
    @results["total_count"].clamp(0, 1_000)
  end
end
