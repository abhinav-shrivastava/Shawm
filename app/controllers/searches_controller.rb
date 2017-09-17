class SearchesController < ApplicationController
  include SearchHelper

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    if @search.save
      @matching_artists = matching_artists @search.query
      byebug
    else
      flash[:error] = 'Try searching again!'
      redirect_to search_url
    end
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end
end
