require 'spec_helper'
require 'highline/import'

describe InstaReadability::Auth do
  let(:consumer) { stub(:get_access_token) }

  before do
    InstaReadability.configure

    @old_stdout = $stdout
    @old_stdin  = $stdin
    $stdin      = StringIO.new
    $stdout     = StringIO.new
    @terminal   = ::HighLine.new($stdin, $stdout)
    HighLine.stubs(:new).returns @terminal
    @terminal.stubs(:ask).with('Username: ').returns 'wmernagh'
    @terminal.stubs(:ask).with('Password: ').returns 'my-password'
    OAuth::Consumer.stubs(:new).with(Readit::Config.consumer_key, Readit::Config.consumer_secret, :site=>"https://www.readability.com/", :access_token_path => "/api/rest/v1/oauth/access_token/").returns consumer
  end

  after do
    $stdin  = @old_stdin
    $stdout = @old_stdout
  end

  describe '.get_access_token' do
    it 'prompts the user for their username' do
      InstaReadability::Auth.get_access_token
      expect(@terminal).to have_received(:ask).with "Username: "
    end

    it 'prompts the user for their password' do
      InstaReadability::Auth.get_access_token
      expect(@terminal).to have_received(:ask).with "Password: "
    end

    it 'returns the authenticated Readability token' do
      consumer.stubs(:get_access_token).with(nil, {}, {:x_auth_mode => 'client_auth', :x_auth_username => 'wmernagh', :x_auth_password => 'my-password'}).returns 'token'
      expect(InstaReadability::Auth.get_access_token).to eq 'token'
    end
  end
end
