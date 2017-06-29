require 'spec_helper'
require 'swagger_hub_api_pusher/pusher'

describe SwaggerHubApiPusher::Pusher do
  describe '#execute' do
    subject { described_class.new }

    context 'when config is invalid?' do
      before do
        allow(SwaggerHubApiPusher.config).to receive(:valid?).and_return(false)
      end

      it 'raises error' do
        expect { subject.execute }.to raise_error(ArgumentError)
      end
    end

    context 'when config is valid?' do
      before do
        SwaggerHubApiPusher.configure do |config|
          config.owner = 'owner'
          config.api_name = 'api_name'
          config.api_key = 'api_key'
          config.version = 'version'
          config.swagger_file = 'spec/fixtures/swagger.json'
        end
      end

      let(:url) { "#{SwaggerHubApiPusher::Pusher::BASE_URL}/owner/api_name?version=version" }
      let(:options) do
        {
          body: File.read('spec/fixtures/swagger.json'),
          headers: {
            'Content-Type' => 'application/json',
            'Authorization' => 'api_key'
          }
        }
      end
      let(:successful_response) {{ status: 200, body: "", headers: {} }}
      let(:failure_response) {{ status: 401, body: { 'message' => 'error' }.to_json }}

      context 'when response succeed' do
        before do
          stub_request(:post, url).with(options).to_return(successful_response)
        end

        it 'logs success message' do
          expect(subject.execute).to eq 'swagger.json was successfully posted'
        end
      end

      context 'when response failed' do
        before do
          stub_request(:post, url).with(options).to_return(failure_response)
        end

        it 'logs error message' do
          expect(subject.execute).to eq 'error'
        end
      end
    end
  end
end
