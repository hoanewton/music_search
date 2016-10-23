# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do
  artist = Artist.create!(name: Faker::Name.name)
  10.times do
    album = Album.create!(title: Faker::Name.name, artist: artist, year: Faker::Date.between(20.years.ago, Date.today).strftime('%Y'))
    5.times do
      Song.create!(title: Faker::Name.name, artist: artist, album: album)
    end
  end
end
