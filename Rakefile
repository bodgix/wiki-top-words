# encoding: UTF-8

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

task default: %w(test)
task test: [:spec, :rubocop]
task :rubocop do
  sh 'rubocop'
end
