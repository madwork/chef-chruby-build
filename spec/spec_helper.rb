require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.log_level  = :error
  config.platform   = 'ubuntu'
  config.version    = '16.04'
end
