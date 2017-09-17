class SearchesController < ApplicationController
  include SearchHelper

  def new
    @search = Search.new
  end

  def create
    @search = current_user.searches.build(search_params)
    if @search.save
      @matching_artists = matching_artists @search.query
      @artist_info = artist_info @search.query
      if @matching_artists.empty?
        flash[:danger] = "No resuls found for #{@search.query}, try something else!"
        redirect_to search_url
      end
    else
      flash[:danger] = 'Try searching again!'
      redirect_to search_url
    end
  end

  private

  def search_params
    params.require(:search).permit(:query)
  end
end
