# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/markleft_task"

Minitest::MarkleftTask.create

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[test rubocop]
