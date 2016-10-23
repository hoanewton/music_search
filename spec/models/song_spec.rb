require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'class methods' do
    describe 'search' do
      context 'when searching for song by title' do
        let(:song) { FactoryGirl.create(:song) }

        it 'returns all songs that match' do
	        expect(Song.search(title: song.title).pluck(:id)).to eql([song.id])
        end
      end

      context 'when searching for song by artist' do
	      let!(:artist) { FactoryGirl.create(:artist) }
        let!(:song) { FactoryGirl.create(:song, artist: artist) }

        it 'returns all songs that match' do
	        expect(Song.search(artist: artist.name).pluck(:id)).to eql([song.id])
        end
      end

      context 'when searching for song by album' do
        let!(:album) { FactoryGirl.create(:album) }
        let!(:song) { FactoryGirl.create(:song, album: album) }

        it 'returns all songs that match' do
          expect(Song.search(album: album.title).pluck(:id)).to eql([song.id])
        end
      end

      context 'when searching for song by title and artist' do
        let!(:artist) { FactoryGirl.create(:artist) }
        let!(:song) { FactoryGirl.create(:song, artist: artist) }

        it 'returns all songs that match' do
          expect(Song.search(title: song.title, artist: artist.name).pluck(:id)).to eql([song.id])
        end
      end

      context 'when searching for song by title and album' do
        let!(:album) { FactoryGirl.create(:album) }
        let!(:song) { FactoryGirl.create(:song, album: album) }

        it 'returns all songs that match' do
          expect(Song.search(title: song.title, album: album.title).pluck(:id)).to eql([song.id])
        end
      end

      context 'when searching for song by artist and album' do
        let!(:album) { FactoryGirl.create(:album) }
        let!(:artist) { FactoryGirl.create(:artist) }
        let!(:song) { FactoryGirl.create(:song, album: album, artist: artist) }

        it 'returns all songs that match' do
          expect(Song.search(artist: artist.name, album: album.title).pluck(:id)).to eql([song.id])
        end
      end

    end
  end
end
