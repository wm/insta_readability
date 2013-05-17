require 'highline/import'
require 'oauth'
require 'readit'

module InstaReadability
  class Auth
    def self.get_access_token
      uname  = highline.ask ("Username: ")
      passwd = highline.ask ("Password: ") {|q| q.echo = false}

      consumer = ::OAuth::Consumer.new(Readit::Config.consumer_key, Readit::Config.consumer_secret, :site=>"https://www.readability.com/", :access_token_path => "/api/rest/v1/oauth/access_token/")
      consumer.get_access_token(nil, {}, {:x_auth_mode => 'client_auth', :x_auth_username => uname, :x_auth_password => passwd})
    end

    private

    def self.highline
      HighLine.new
    end
  end
end
