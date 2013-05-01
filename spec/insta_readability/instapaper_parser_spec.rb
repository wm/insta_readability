require 'spec_helper'

describe InstaReadability::InstapaperParser do
  let(:csv)  { '/path/to/file' }

  let(:rows) do
    [
      {
        'URL'        => 'http://t.co/4MPuTK9dXn',
        'Title'      => 'A silly title',
        'Selection'  => 'No one cares',
        'Folder'     => 'Archive',
      },
      {
        'URL'        => 'http://t.co/guSIBHxBaV',
        'Title'      => 'Some silly title',
        'Selection'  => 'Who cares',
        'Folder'     => 'Starred',
      },
      {
        'URL'        => 'http://t.co/9FDQCZLDQm',
        'Title'      => 'Another title',
        'Selection'  => 'Who cares',
        'Folder'     => 'Unread',
      }
    ]
  end

  subject(:parser) { InstaReadability::InstapaperParser.new csv }

  before do
    CSV.stubs(:foreach).with(csv, headers: true).multiple_yields(*rows.collect{|row| [row]})
  end

  describe 'new' do
    it 'sets the csv instance variable' do
      expect(parser.instance_variable_get(:@csv_path)).to be csv
    end
  end

  describe '.parse' do
    it 'parses the csv into bookmarks' do
      book_params1 = { url: 'http://t.co/4MPuTK9dXn', favorite: false, archive: true }
      book_params2 = { url: 'http://t.co/guSIBHxBaV', favorite: true, archive: false }
      book_params3 = { url: 'http://t.co/9FDQCZLDQm', favorite: false, archive: false }
      bookmarks    = [InstaReadability::Bookmark.new(book_params1), InstaReadability::Bookmark.new(book_params2), InstaReadability::Bookmark.new(book_params3)]

      expect(parser.create_bookmarks).to eq bookmarks
    end
  end
end
