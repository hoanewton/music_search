class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :songs

  validates :title, :year, :artist, presence: true
end
