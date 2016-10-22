class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :album

  validates :artist, :album, presence: true

  def search(options={})
  end
end
