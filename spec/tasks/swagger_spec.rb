require "spec_helper"

describe "rake swagger:push", type: :task do
  it "does not raise errors" do
    expect { task.execute }.not_to raise_error
  end

  it "logs to stdout" do
    expect { task.execute }.to output("Pushing...\n").to_stdout
  end
end
