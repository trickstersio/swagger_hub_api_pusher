require 'swagger_hub_api_pusher/pusher'
require 'swagger_hub_api_pusher'

namespace :swagger do
  desc 'Push swagger json to SwaggerHub API'
  task push: :environment do
    response = SwaggerHubApiPusher::Pusher.new.execute
    abort response unless response.nil?
  end
end
