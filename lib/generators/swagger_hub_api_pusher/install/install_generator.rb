require 'rails/generators'

module SwaggerHubApiPusher
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def add_initializer
      template('swagger_hub_api_pusher.rb', 'config/initializers/swagger_hub_api_pusher.rb')
    end
  end
end
