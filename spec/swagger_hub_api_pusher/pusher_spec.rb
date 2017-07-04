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

      let(:get_api_version_url) { "#{SwaggerHubApiPusher::Pusher::BASE_URL}/owner/api_name/version/swagger.json" }
      let(:post_api_url) { "#{SwaggerHubApiPusher::Pusher::BASE_URL}/owner/api_name?version=version" }
      let(:options) {{ headers: { 'Content-Type' => 'application/json', 'Authorization' => 'api_key' } }}

      let(:not_found_response) {{ status: 404, body: { 'message' => 'Not Found' }.to_json }}
      let(:successful_response) {{ status: 200, body: "", headers: {} }}
      let(:failure_response) {{ status: 401, body: { 'message' => 'error' }.to_json }}

      context 'when pushed version not found' do
        before do
          stub_request(:get, get_api_version_url)
            .with(options)
            .to_return(not_found_response)
        end

        context 'when pushing version succeed' do
          before do
            stub_request(:post, post_api_url)
              .with(options.merge(body: File.read('spec/fixtures/swagger.json')))
              .to_return(successful_response)
          end

          it 'returns nil' do
            expect(subject.execute).to be_nil
          end
        end

        context 'when pushing version failed' do
          before do
            stub_request(:post, post_api_url)
              .with(options.merge(body: File.read('spec/fixtures/swagger.json')))
              .to_return(failure_response)
          end

          it 'logs error message' do
            expect(subject.execute).to eq 'error'
          end
        end
      end

      context 'when pushed version not changed' do
        before do
          stub_request(:get, get_api_version_url)
            .with(options)
            .to_return(successful_response.merge(body: File.read('spec/fixtures/swagger.json')))
        end

        it 'returns nil without pushing version' do
          expect(subject.execute).to be_nil
        end
      end

      context 'when pushed version changed' do
        before do
          stub_request(:get, get_api_version_url)
            .with(options)
            .to_return(successful_response.merge(body: { 'a' => 1 }.to_json))
        end

        context 'when pushing version succeed' do
          before do
            stub_request(:post, post_api_url)
              .with(options.merge(body: File.read('spec/fixtures/swagger.json')))
              .to_return(successful_response)
          end

          it 'returns nil' do
            expect(subject.execute).to be_nil
          end
        end

        context 'when pushing version failed' do
          before do
            stub_request(:post, post_api_url)
              .with(options.merge(body: File.read('spec/fixtures/swagger.json')))
              .to_return(failure_response)
          end

          it 'logs error message' do
            expect(subject.execute).to eq 'error'
          end
        end
      end
    end
  end
end
