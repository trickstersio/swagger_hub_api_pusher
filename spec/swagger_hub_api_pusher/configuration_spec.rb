require 'spec_helper'
require 'swagger_hub_api_pusher/configuration'

describe SwaggerHubApiPusher::Configuration do
  subject(:config) { described_class.new }

  describe 'attributes' do
    before do
      config.owner = 'owner'
      config.api_name = 'api_name'
      config.api_key = 'api_key'
      config.version = 'version'
      config.swagger_file = 'swagger_file'
    end

    it 'sets corresponding attributes' do
      is_expected.to have_attributes(
        owner: 'owner',
        api_name: 'api_name',
        api_key: 'api_key',
        version: 'version',
        swagger_file: 'swagger_file'
      )
    end
  end

  describe '#valid?' do
    subject { config.valid? }

    context 'when all attributes presents' do
      before do
        config.owner = 'owner'
        config.api_name = 'api_name'
        config.api_key = 'api_key'
        config.version = 'version'
        config.swagger_file = 'swagger_file'
      end

      it { is_expected.to be true }
      it 'does not set errors_messages' do
        subject
        expect(config.errors_messages).to be_empty
      end
    end

    context 'when some of attributes are blank' do
      before do
        config.api_name = 'api_name'
        config.api_key = 'api_key'
        config.version = 'version'
      end

      it { is_expected.to be false }
      it 'sets errors_messages for missed attributes' do
        subject
        expect(config.errors_messages).to eq 'owner is blank, swagger_file is blank'
      end
    end
  end
end
