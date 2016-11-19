require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'class methods' do
    describe 'search' do
      context 'when searching for song by title' do
        let(:song) { FactoryGirl.create(:song) }

        it 'returns all songs that match' do
	        expect(Song.search(search: {"songs_title" => song.title}).pluck(:title)).to include(song.title)
        end
      end

      context 'when searching for song by artist' do
	      let!(:artist) { FactoryGirl.create(:artist) }
        let!(:song) { FactoryGirl.create(:song, artist: artist) }

        it 'returns all songs that match' do
	        expect(Song.search(search: {"artists_name" => artist.name}).pluck(:title)).to include(song.title)
        end
      end

      context 'when searching for song by album' do
        let!(:album) { FactoryGirl.create(:album) }
        let!(:song) { FactoryGirl.create(:song, album: album) }

        it 'returns all songs that match' do
          expect(Song.search(search: {"albums_title" => album.title}).pluck(:title)).to include(song.title)
        end
      end

      context 'when searching for song by title and artist' do
        let!(:artist) { FactoryGirl.create(:artist) }
        let!(:song) { FactoryGirl.create(:song, artist: artist) }

        it 'returns all songs that match' do
          expect(Song.search(search: {"songs_title" => song.title, "artists_name" => artist.name}).pluck(:title)).to include(song.title)
        end
      end

      context 'when searching for song by title and album' do
        let!(:album) { FactoryGirl.create(:album) }
        let!(:song) { FactoryGirl.create(:song, album: album) }

        it 'returns all songs that match' do
          expect(Song.search(search: {"songs_title" => song.title, "albums_title" => album.title}).pluck(:title)).to include(song.title)
        end
      end

      context 'when searching for song by artist and album' do
        let!(:album) { FactoryGirl.create(:album) }
        let!(:artist) { FactoryGirl.create(:artist) }
        let!(:song) { FactoryGirl.create(:song, album: album, artist: artist) }

        it 'returns all songs that match' do
          expect(Song.search(search: {"artists_name" => artist.name, "albums_title" => album.title}).pluck(:title)).to include(song.title)
        end
      end

      context 'when searching for song by partial of song title' do
        let!(:album) { FactoryGirl.create(:album) }
        let!(:artist) { FactoryGirl.create(:artist) }
        let!(:song) { FactoryGirl.create(:song, title: 'Here comes the Sun', album: album, artist: artist) }

        it 'returns all songs that have the search term' do
          expect(Song.search(search: {"songs_title" => 'the Sun'}).pluck(:id)).to include(song.id)
        end
      end

      context 'when searching for song by partial of artist name' do
        let!(:album) { FactoryGirl.create(:album) }
        let!(:artist) { FactoryGirl.create(:artist, name: 'The Rolling Stones') }
        let!(:song) { FactoryGirl.create(:song, title: 'Start me up', album: album, artist: artist) }
        it 'returns all songs that have artist name with term' do
          expect(Song.search(search: {"artists_name" => 'stones'}).pluck(:title)).to include(song.title)
        end
      end

      context 'when searching for song by partial of album title' do
        let!(:album) { FactoryGirl.create(:album, title: 'Out of Our Heads') }
        let!(:artist) { FactoryGirl.create(:artist) }
        let!(:song) { FactoryGirl.create(:song, album: album, artist: artist) }
        it 'returns all songs that have artist name with term' do
          expect(Song.search(search: {"albums_title" => 'out of'}).pluck(:title)).to include(song.title)
        end
      end

      context 'when searching for song by partial of album title and artist name' do
        let!(:album) { FactoryGirl.create(:album, title: 'Out of Our Heads') }
        let!(:artist) { FactoryGirl.create(:artist, name: 'The Rolling Stones' ) }
        let!(:song) { FactoryGirl.create(:song, album: album, artist: artist) }
        it 'returns all songs that have artist name with term' do
          expect(Song.search(search: {"albums_title" => 'out of', "artists_name" => 'Stones'}).pluck(:title)).to include(song.title)
        end
      end
    end
  end
end
