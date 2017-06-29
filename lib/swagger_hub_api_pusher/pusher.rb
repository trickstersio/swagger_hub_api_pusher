require 'uri'
require 'net/https'

module SwaggerHubApiPusher
  class Pusher
    SUCCESS_STATUSES = [200, 201].freeze
    BASE_URL = 'https://api.swaggerhub.com/apis/'.freeze

    def execute
      raise ArgumentError, config.errors_messages unless config.valid?

      uri = URI.parse(url)
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'application/json'
      request['Authorization'] = config.api_key
      request.body = File.read(config.swagger_file)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      if SUCCESS_STATUSES.include?(response.code.to_i)
        puts 'swagger.json was successfully posted'
      else
        puts JSON.parse(response.body)['message']
      end
    end

    private def url
      "#{BASE_URL}/#{config.owner}/#{config.api_name}?version=#{config.version}"
    end

    private def config
      @config ||= SwaggerHubApiPusher.config
    end
  end
end
