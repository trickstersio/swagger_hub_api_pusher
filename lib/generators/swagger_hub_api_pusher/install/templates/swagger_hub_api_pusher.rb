SwaggerHubApiPusher.configure do |c|
  # Specify owner, api_name, api_key, version and swagger_file from swaggerhub settings
  # This is used by the SwaggerHubApiPusher to pushing swagger.json file
  c.owner = 'owner'
  c.api_name = 'api_name'
  c.api_key = 'api_key'
  c.version = 'version'
  c.swagger_file = 'swagger/v1/swagger.json'
end
