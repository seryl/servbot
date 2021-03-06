require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "servbot"
  gem.homepage = "http://github.com/seryl/servbot"
  gem.license = "GPL"
  gem.summary = %Q{Servbot is a fully extensible Eventmachine based IRC bot.}
  gem.description = %Q{Servbot is a fully extensible Eventmachine based IRC bot.}
  gem.email = "joshtoft@gmail.com"
  gem.authors = ["Josh Toft"]
  gem.add_runtime_dependency 'eventmachine', '>= 0.12.10'
  #gem.add_development_dependency 'flexmock', '>= 0'
  gem.add_development_dependency 'rcov', '>= 0'
  gem.add_development_dependency 'rspec', '>= 0'
  #gem.files.include 'template/*'
  #gem.files.include 'config/*'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

require 'metric_fu'
MetricFu::Configuration.run do |config|
  #config.metrics  = [:churn, :saikuro, :stats, :flog, :flay]
  config.metrics  = [:saikuro, :flog, :flay, :rcov, :roodi, :reek]
  #config.graphs   = [:flog, :flay, :stats]
  config.graphs   = [:flog, :flay, :rcov, :roodi, :reek]
  config.rcov[:test_files] = ['spec/**/*_spec.rb']
end

task :default => :spec

desc 'Build the manual'
task :man do
  sh "ronn -w -s toc -br5 --organization=SERYL man/*.ronn"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "servbot #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('CHANGELOG*')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.options << '--inline-source'
  rdoc.options << '--line-numbers'
end
