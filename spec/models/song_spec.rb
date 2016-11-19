require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'class methods' do
    describe 'search' do
      context 'positive senarios' do
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

      context 'negative senarios' do
        context 'when searching for song by title' do
          let(:song) { FactoryGirl.create(:song, title: 'Hello') }

          it 'returns nothing if no songs match' do
            expect(Song.search(search: {"songs_title" => "Yesterday"})).to be_empty
          end
        end

        context 'when searching for song by artist' do
          let!(:artist) { FactoryGirl.create(:artist, name: 'The Rolling Stones') }
          let!(:song) { FactoryGirl.create(:song, artist: artist) }

          it 'returns nothing if no aritsts match' do
            expect(Song.search(search: {"artists_name" => "Maroon 5"})).to be_empty
          end
        end

        context 'when searching for song by album' do
          let!(:album) { FactoryGirl.create(:album, title: 'Hello') }
          let!(:song) { FactoryGirl.create(:song, album: album) }

          it 'returns nothing if no albums match' do
            expect(Song.search(search: {"albums_title" => "Yesterday"})).to be_empty
          end
        end

        context 'when searching for song by title and artist' do
          let!(:artist) { FactoryGirl.create(:artist, name: 'The Beatles') }
          let!(:song) { FactoryGirl.create(:song, title: 'Yesterday', artist: artist) }

          it 'returns nothing if no title and artist do not match' do
            expect(Song.search(search: {"songs_title" => "Telephone", "artists_name" => "Lady Gaga"})).to be_empty
          end
        end

        context 'when searching for song by title and album' do
          let!(:album) { FactoryGirl.create(:album, title: 'The Fame Monster') }
          let!(:song) { FactoryGirl.create(:song, title: 'Telephone', album: album) }

          it 'returns nothing if no title and album match' do
            expect(Song.search(search: {"songs_title" => song.title, "albums_title" => "Songs About Jane"})).to be_empty
          end
        end

        context 'when searching for song by artist and album' do
          let!(:album) { FactoryGirl.create(:album, title: 'Songs about Jane') }
          let!(:artist) { FactoryGirl.create(:artist, name: 'Maroon 5') }
          let!(:song) { FactoryGirl.create(:song, album: album, artist: artist) }

          it 'returns nothing if no album and artist match' do
            expect(Song.search(search: {"artists_name" => "Maroon 5", "albums_title" => "25"})).to be_empty
          end
        end

        context 'when searching for song by partial of song title' do
          let!(:album) { FactoryGirl.create(:album) }
          let!(:artist) { FactoryGirl.create(:artist) }
          let!(:song) { FactoryGirl.create(:song, title: 'Here comes the Sun', album: album, artist: artist) }

          it 'returns nothing if no partial match' do
            expect(Song.search(search: {"songs_title" => 'The icecream man'})).to be_empty
          end
        end

        context 'when searching for song by partial of artist name' do
          let!(:album) { FactoryGirl.create(:album) }
          let!(:artist) { FactoryGirl.create(:artist, name: 'The Rolling Stones') }
          let!(:song) { FactoryGirl.create(:song, title: 'Start me up', album: album, artist: artist) }
          it 'returns nothing if no artist found' do
            expect(Song.search(search: {"artists_name" => 'Beatles'})).to be_empty
          end
        end

        context 'when searching for song by partial of album title' do
          let!(:album) { FactoryGirl.create(:album, title: 'Out of Our Heads') }
          let!(:artist) { FactoryGirl.create(:artist) }
          let!(:song) { FactoryGirl.create(:song, album: album, artist: artist) }
          it 'returns nothing if no album found' do
            expect(Song.search(search: {"albums_title" => '1234'})).to be_empty
          end
        end

        context 'when searching for song by partial of album title and artist name' do
          let!(:album) { FactoryGirl.create(:album, title: 'Out of Our Heads') }
          let!(:artist) { FactoryGirl.create(:artist, name: 'The Rolling Stones' ) }
          let!(:song) { FactoryGirl.create(:song, album: album, artist: artist) }
          it 'returns nothing if no album and artist name with term' do
            expect(Song.search(search: {"albums_title" => '23', "artists_name" => 'Stones'})).to be_empty
          end
        end
      end
    end
  end
end
