# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"

Minitest::TestTask.create(:test) do |t|
  t.test_globs = FileList["test/**/*_test.rb"]
  t.libs << "test"
  t.libs << "lib"
end

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[test rubocop]
