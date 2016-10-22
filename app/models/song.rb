class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :album

  validates :title, :artist, :album, presence: true

  def self.search(options={})
    Song.where(title: options[:title])
  end
end
