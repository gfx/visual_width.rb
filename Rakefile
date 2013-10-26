require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :data do
  sh "tool/east-asian-width.pl > lib/visual_width/data.rb"
end

task :bench do
  sh "ruby -Ilib tool/benchmark-measure.rb"
  sh "ruby -Ilib tool/benchmark-table.rb"
end
