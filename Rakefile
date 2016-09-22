# encoding: UTF-8

# rubocop:disable HandleExceptions
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end
# rubocop:enable HandleExceptions

task default: %w(test)
task test: [:spec, :rubocop]
task :rubocop do
  sh 'rubocop'
end
