require 'spec_helper'

describe 'rake swagger:push', type: :task do
  context 'when SwaggerHubApiPusher::Pusher returns nil' do
    before do
      expect(SwaggerHubApiPusher::Pusher).to receive(:new)
        .and_return(double(execute: nil))
    end

    it 'executes successful' do
      expect { task.execute }.not_to raise_error
    end
  end

  context 'when SwaggerHubApiPusher::Pusher returns error message' do
    before do
      expect(SwaggerHubApiPusher::Pusher).to receive(:new)
        .and_return(double(execute: 'Something went wrong'))
    end

    it 'abort execution' do
      expect { task.execute }.to raise_error SystemExit
    end
  end
end
