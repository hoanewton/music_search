require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'class methods' do
    describe 'search' do
      context 'when searching for song by title' do
        let(:song) { FactoryGirl.create(:song) }

        it 'should return all songs that match' do
	        expect(Song.search(title: song.title).pluck(:id)).to eql([song.id])
        end
      end

      context 'when searching for song by artist' do
	      let(:artist) { FactoryGirl.create(:artist) }
        let(:song) { FactoryGirl.create(:song, artist: artist) }

        it 'should return all songs that match' do
	        expect(Song.search(artist_name: artist.name, title: song.title).pluck(:id)).to include(song.id)
        end
      end

    end
  end
end