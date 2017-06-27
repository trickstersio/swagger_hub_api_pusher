require 'spec_helper'
require 'swagger_hub_api_pusher/pusher'

describe SwaggerHubApiPusher::Pusher do
  describe '#execute' do
    subject { described_class.new }

    it 'logs to stdout' do
      expect { subject.execute }.to output("Pushing...\n").to_stdout
    end
  end
end
