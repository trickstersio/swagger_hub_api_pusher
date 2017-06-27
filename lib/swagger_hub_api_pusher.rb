require "swagger_hub_api_pusher/version"
require "swagger_hub_api_pusher/configuration"
require "swagger_hub_api_pusher/railtie" if defined?(Rails)

module SwaggerHubApiPusher
  def self.configure
    yield(config)
  end

  def self.config
    @config ||= Configuration.new
  end
end
