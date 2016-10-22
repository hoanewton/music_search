class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :album
  delegate :title, :to => :album, :prefix => true
  delegate :name, :to => :artist, :prefix => true
  validates :title, :artist, :album, presence: true

  def self.search(options={})
    return Song.where(title: options[:title]) unless options[:artist_name].present?
    # song_title_result = Song.where("title like ?", "%#{options[:title]}%")
    artist_name_result = Song.joins(:artist).where(artists: { name: options[:artist_name]}, title: options[:title])
  end
end
