require 'uri'
require 'net/https'
require 'json'

module SwaggerHubApiPusher
  class Pusher
    SUCCESS_STATUSES = [200, 201].freeze
    NOT_FOUND_STATUS = 404
    BASE_URL = 'https://api.swaggerhub.com/apis'.freeze

    def execute
      raise ArgumentError, config.errors_messages unless config.valid?

      return unless version_changed?

      response = push_swagger_file

      unless SUCCESS_STATUSES.include?(response.code.to_i)
        JSON.parse(response.body)['message']
      end
    end

    private def version_changed?
      response = perform_request Net::HTTP::Get, get_api_version_url
      NOT_FOUND_STATUS == response.code.to_i || JSON.parse(response.body) != JSON.parse(swagger_file)
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

    private def get_api_version_url
      "#{BASE_URL}/#{config.owner}/#{config.api_name}/#{config.version}/swagger.json"
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
