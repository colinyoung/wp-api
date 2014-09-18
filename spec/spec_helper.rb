require 'bundler/setup'
require 'rspec/its'
Bundler.setup

$LOAD_PATH << File.dirname(__FILE__) + "/../"

require 'wp/api'

require 'spec/helpers/files_helper'
require 'spec/helpers/wordpress_helper'
require 'spec/helpers/json_helper'
require 'spec/support/mock_wordpress_server'

RSpec.configure do |config|
  # some (optional) config here
  config.before do |example|
    @mock_server ||= MockWordpressServer.new
  end

  config.include FilesHelper
  config.include JSONHelper
  config.include WordpressHelper
end
