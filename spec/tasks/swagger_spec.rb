require 'spec_helper'

describe 'rake swagger:push', type: :task do
  it 'delegates execution to SwaggerHubApiPusher::Pusher' do
    expect(SwaggerHubApiPusher::Pusher).to receive(:new).and_return(double(execute: true))
    task.execute
  end
end
