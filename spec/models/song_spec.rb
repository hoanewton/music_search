require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'class methods' do
    describe 'search' do
      context 'when searching by song' do
        let(:song) { FactoryGirl.create(:song) }

        it 'should return all songs that match' do
	  expect(Song.search(title: song.title).pluck(:id)).to eql([song.id])
        end
      end
    end
  end
end
