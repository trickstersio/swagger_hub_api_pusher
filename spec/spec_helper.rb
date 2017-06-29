require "bundler/setup"
require "swagger_hub_api_pusher"
require "support/task_example_group"
require 'webmock/rspec'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Tag Rake specs with `:task` metadata or put them in the spec/tasks dir
  config.define_derived_metadata(:file_path => %r{/spec/tasks/}) do |metadata|
    metadata[:type] = :task
  end

  config.include TaskExampleGroup, type: :task

  config.before(:suite) do
    Dir.glob('lib/tasks/*.rake').each {|r| load r}
  end
end
