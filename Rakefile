require './app'
require 'sinatra/activerecord/rake'
require 'rspec/core'
require 'rspec/core/rake_task'

task :default => :server

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec)

desc "Run the application"
task :server do
  Sinatra::Application.run!
end

task :bark do
  Hook.all.each do |hook|
    message = Fact.get_random.first.message
    Dog.bark_to(hook.url, message)
  end
end
