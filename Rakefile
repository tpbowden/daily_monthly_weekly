require "rubocop/rake_task"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new "rspec"

RuboCop::RakeTask.new

task default: %i(
  rubocop
  rspec
  cucumber
)
