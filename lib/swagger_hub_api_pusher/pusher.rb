require 'httparty'

module SwaggerHubApiPusher
  class Pusher
    def execute
      raise ArgumentError, config.errors_messages unless config.valid?

      response = Client.post(url,
        body: File.read(config.swagger_file),
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => config.api_key
        }
      )

      if response.success?
        puts 'swagger.json was successfully posted'
      else
        puts JSON.parse(response.body)['message']
      end
    end

    private def url
      "/#{config.owner}/#{config.api_name}?version=#{config.version}"
    end

    private def config
      @config ||= SwaggerHubApiPusher.config
    end

    class Client
      include HTTParty
      base_uri 'https://api.swaggerhub.com/apis'
    end
  end
end
