module SwaggerHubApiPusher
  class Configuration
    attr_accessor :owner, :api_name, :api_key, :version, :swagger_file

    def valid?
      [:owner, :api_name, :api_key, :version, :swagger_file].each do |param|
        value = public_send(param)
        errors[param] = 'is blank' if !value || value.empty?
      end
      errors.empty?
    end

    def errors_messages
      errors.map { |k, v| "#{k} #{v}" }.join(', ')
    end

    private def errors
      @errors ||= {}
    end
  end
end
