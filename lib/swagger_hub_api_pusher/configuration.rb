module SwaggerHubApiPusher
  class Configuration
    attr_accessor :owner, :api_name, :api_key, :version, :swagger_file

    def valid?
      [:owner, :api_name, :api_key, :version, :swagger_file].each do |param|
        errors[param] = 'is blank' if is_blank?(public_send(param))
      end

      errors[:swagger_file] = 'not found' if !is_blank?(swagger_file) && file_not_found?

      errors.empty?
    end

    def errors_messages
      errors.map { |k, v| "#{k} #{v}" }.join(', ')
    end

    private def errors
      @errors ||= {}
    end

    private def is_blank?(value)
      !value || value.empty?
    end

    private def file_not_found?
      !File.exists?(swagger_file)
    end
  end
end
