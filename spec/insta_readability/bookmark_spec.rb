require 'spec_helper'

describe InstaReadability::Bookmark do
  describe 'new' do
    context 'default bookmark' do
      subject(:bookmark) { InstaReadability::Bookmark.new }

      it 'sets default parameters to false' do
        expect(bookmark.favorite).to be 0
        expect(bookmark.archive).to be 0
        expect(bookmark.allow_duplicates).to be 0
      end
    end

    context 'custom bookmark' do
      subject(:bookmark) do
        InstaReadability::Bookmark.new url: 'url', favorite: true, archive: true
      end

      it 'assigns passed in parameters' do
        expect(bookmark.favorite).to be true
        expect(bookmark.archive).to be true
        expect(bookmark.url).to eq 'url'
      end
    end
  end

  describe '==' do
    let(:source) { InstaReadability::Bookmark.new(url: 1, favorite: 2, archive: 3) }

    context 'all attributes are equal' do
      let(:bookmark) { InstaReadability::Bookmark.new(url: 1, favorite: 2, archive: 3) }

      it 'is returns true' do
        expect(source == bookmark).to be true
      end
    end

    context 'an attribute is different' do
      let(:bookmark) { InstaReadability::Bookmark.new(url: 4, favorite: 2, archive: 3) }

      it 'returns false' do
        expect(source == bookmark).to be false
      end
    end
  end

  describe '#to_hash' do
    let(:bookmark) { InstaReadability::Bookmark.new(url: 1, favorite: 2, archive: 3) }

    it 'returns a hash of instance variables' do
      expect(bookmark.to_hash).to eq({ url: 1, favorite: 2, archive: 3, :allow_duplicates=>0 })
    end
  end
end
