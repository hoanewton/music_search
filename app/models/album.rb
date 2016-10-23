class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :songs, dependent: :destroy

  validates :title, :year, :artist, presence: true
end
