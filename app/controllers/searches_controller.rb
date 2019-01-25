class SearchesController < ApplicationController
  def index
    if params[:term]
      @results = Github::Search.new.repositories(search_params)
    else
      @results = []
    end
  end

  private

  def search_params
    params.permit(:term, :sort_by, :per_page).to_h.symbolize_keys
  end
end
