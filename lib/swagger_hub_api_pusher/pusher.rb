require 'uri'
require 'net/https'
require 'json'

module SwaggerHubApiPusher
  class Pusher
    SUCCESS_STATUSES = [200, 201].freeze
    BASE_URL = 'https://api.swaggerhub.com/apis'.freeze
    VERSION_REGEX = /(\d+\.)?(\d+\.)?(\*|\d+)/

    def execute
      raise ArgumentError, config.errors_messages unless config.valid?

      return if published_api_is_actual?

      response = push_swagger_file

      unless SUCCESS_STATUSES.include?(response.code.to_i)
        JSON.parse(response.body)['message']
      end
    end

    private def published_api_is_actual?
      response = perform_request Net::HTTP::Get, get_api_url
      return unless SUCCESS_STATUSES.include?(response.code.to_i)

      apis = JSON.parse(response.body)['apis']
      last_published_api = apis.reverse.find do |api|
        api['properties'].find do |pr|
          pr['type'] == 'X-Published' && pr['value'] == 'true'
        end
      end
      return unless last_published_api

      last_published_version = last_published_api['properties'].find { |pr| pr['type'] == 'X-Version' }['value']
      version(config.version) <= version(last_published_version)
    end

    private def version(version_str)
      matched = VERSION_REGEX.match(version_str)
      Gem::Version.new(matched ? matched[0] : nil)
    end

    private def push_swagger_file
      perform_request Net::HTTP::Post, post_api_url, swagger_file
    end

    private def perform_request(request_class, url, body = nil)
      uri = URI.parse(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = request_class.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      request['Authorization'] = config.api_key
      request.body = body unless body.nil?

      http.request(request)
    end

    private def get_api_url
      "#{BASE_URL}/#{config.owner}/#{config.api_name}"
    end

    private def post_api_url
      "#{BASE_URL}/#{config.owner}/#{config.api_name}?version=#{config.version}"
    end

    private def swagger_file
      @swagger_file ||= File.read(config.swagger_file)
    end

    private def config
      @config ||= SwaggerHubApiPusher.config
    end
  end
end
