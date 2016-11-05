class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :album
  delegate :title, :to => :album, :prefix => true
  delegate :name, :to => :artist, :prefix => true
  validates :title, :artist, :album, presence: true

  def self.search(terms={})
    filter = []
    filter << "songs.title like '%#{terms[:title].squish}%'" if terms[:title].present?
    filter << "artists.name like '%#{terms[:artist_name].squish}%'" if terms[:artist_name].present?
    filter << "albums.title like '%#{terms[:album_title].squish}%'" if terms[:album_title].present?
    search_query = filter.length <= 1 ? filter.flatten.join('') : filter.join(' and ')
puts "SEARCH TERMS: #{terms}, FILTER: #{filter}, QUERY: #{search_query}" 

    Song.joins(:artist, :album).includes(:artist, :album).where(search_query)
  end

end