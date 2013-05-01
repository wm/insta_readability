require 'spec_helper'

describe InstaReadability::Importer do
  let(:token)  { 'access token' }
  let(:secret) { 'access token secret' }
  let(:api)    { mock }
  let(:logger) { mock }

  subject(:importer) { InstaReadability::Importer.new token, secret, logger }

  before do
    Readit::API.stubs(:new).with(token, secret).returns api
  end

  describe 'initialize' do
    it 'sets a readit api instance' do
      expect(importer.instance_variable_get(:@api)).to be api
    end
  end

  describe '#import' do
    let(:bookmarks) { [1, 2, 3] }
    let(:status)    { {:status => '202',:bookmark_id => '233444', :article_id => 't323r2'} }

    before do
      logger.stubs(:info)
      importer.stubs(:save).returns(status)
      importer.import bookmarks
    end

    it 'imports each bookmark' do
      bookmarks.each do |bookmark|
        expect(importer).to have_received(:save).with bookmark
      end
    end

    it 'logs the result of the import' do
      expect(logger).to have_received(:info).with(status).times(3)
    end
  end

  describe '#save!' do
    let(:bookmark) { InstaReadability::Bookmark.new(url: 4, favorite: 2, archive: 3) }

    it 'creates a bookmark at Readability' do
      api.stubs(:bookmark)

      importer.save(bookmark)

      expect(api).to have_received(:bookmark).with(bookmark.to_hash)
    end
  end
end
