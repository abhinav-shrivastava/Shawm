module SearchHelper
  # builds the query for searching similar artists
  def query_similar(artist_name = 'Dire+Straits')
    "http://ws.audioscrobbler.com/2.0/?method=artist.search&artist=#{artist_name}&api_key=1ca2cf614eeaa185c2b61753b434b599&format=json"
  end

  def matching_artists(artist_name)
    response = HTTP.get query_similar artist_name
    resp = JSON.parse(response)
    filter_without_image(resp['results']['artistmatches']['artist'])
  end

  # filter out the results which doesn't have associated images
  def filter_without_image(response)
    resp = []
    response.each do |artist_info|
      resp << artist_info if artist_info.dig('image', -2, '#text').present?
    end
    resp
  end
end
