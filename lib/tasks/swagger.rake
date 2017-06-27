require 'swagger_hub_api_pusher/pusher'
require 'swagger_hub_api_pusher'

namespace :swagger do
  desc 'Push swagger json to SwaggerHub API'
  task :push do
    SwaggerHubApiPusher::Pusher.new.execute
  end
end
