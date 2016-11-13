class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :album
  delegate :title, :to => :album, :prefix => true
  delegate :name, :to => :artist, :prefix => true
  validates :title, :artist, :album, presence: true

  def self.search(terms={})
    filter = []
    associations = []

    terms[:search].each do |k,v|
      term = k.sub('_', '.')
      filter << term + ' ' + 'like' + ' ' + "'%#{v}%'"
      associations << k.split('_')[0].singularize.to_sym unless k == 'songs_title'
    end 
    
    search_query = filter.length <= 1 ? filter.flatten.join('') : filter.join(' and ')
    Song.joins(associations.flatten).includes(associations.flatten).where(search_query)
  end


end