require 'spec_helper'

describe InstaReadability::CLI, '.run' do
  let(:access_token) { OpenStruct.new(token: 'token', secret: 'secret') }
  subject(:cli)      { InstaReadability::CLI }

  before do
    InstaReadability.configure
    @old_stderr = $stderr
    $stderr = StringIO.new
    InstaReadability::Auth.stubs(:get_access_token).returns access_token
  end

  after do
    $stderr = @old_stderr
  end

  context 'incorrect args' do
    it 'does not authenticates the user' do
      expect(InstaReadability::Auth).to have_received(:get_access_token).never
    end

    it 'returns without an import attempt' do
      importer = mock
      InstaReadability::Importer.stubs(:new).returns importer

      cli.run

      expect(importer).to have_received(:import).never
    end

    it 'prints out the usage instructions' do
      $stderr.stubs(:print)
      usage_message = "Usage: $0 PATH_TO_CSV_FILE"

      cli.run

      expect($stderr).to have_received(:print).with usage_message
    end
  end

  context 'correct args' do
    let(:importer) { mock(:import) }
    let(:bookmarks) { mock }
    let(:parser)   { mock(create_bookmarks: bookmarks) }

    before do
      csv_path = 'path to csv file'
      InstaReadability::InstapaperParser.stubs(:new).with(csv_path).returns parser
      InstaReadability::Importer.stubs(:new).with(access_token.token, access_token.secret).returns importer
      cli.run csv_path
    end

    it 'authenticates the user' do
      expect(InstaReadability::Auth).to have_received(:get_access_token)
    end

    it 'imports the bookmarks' do
      expect(importer).to have_received(:import).with bookmarks
    end
  end
end
