require 'spec_helper'

describe InstaReadability::Configuration do
  RSpec::Matchers.define :have_config_option do |option|
    match do |config|
      if instance_variables.include?('@default'.to_sym)
        config.send(option) == @default
      end
      config.respond_to?(option) && overridable?(config, option)
    end

    def overridable?(config, option)
      value = 'a value'
      config.send(:"#{option}=", value)

      config.send(option) == value
    end

    chain :default do |default|
      @default = default
    end
  end

  it { should have_config_option(:api_key).   default(nil) }
  it { should have_config_option(:api_secret).default(nil) }
  it { should have_config_option(:parser).    default(InstaReadability::InstapaperParser) }
end
