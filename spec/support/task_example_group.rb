require "rake"

# Task names should be used in the top-level describe, with an optional
# "rake "-prefix for better documentation. Both of these will work:
#
# 1) describe "foo:bar" do ... end
#
# 2) describe "rake foo:bar" do ... end
#
# Favor including "rake "-prefix as in the 2nd example above as it produces
# doc output that makes it clear a rake task is under test and how it is
# invoked.
module TaskExampleGroup
  def self.included(base)
    base.class_eval do
      let(:task_name) { self.class.top_level_description.sub(/\Arake /, "") }
      let(:tasks) { Rake::Task }

      # Make the Rake task available as `task` in your examples:
      subject(:task) { tasks[task_name] }
    end
  end
end
