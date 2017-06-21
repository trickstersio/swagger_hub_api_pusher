require 'swagger_hub_api_pusher'
require 'rails'

module SwaggerHubApiPusher
  class Railtie < Rails::Railtie
    railtie_name :swagger_hub_api_pusher

    rake_tasks do
      load "tasks/swagger.rake"
    end
  end
end
