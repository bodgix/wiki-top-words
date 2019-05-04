# frozen_string_literal: true

# rubocop:disable HandleExceptions
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end
# rubocop:enable HandleExceptions

task default: %w[test]
task test: %i[spec rubocop]
task :rubocop do
  sh 'rubocop'
end
