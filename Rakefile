
# -*- ruby -*-

require 'rubygems'
require 'rubygems/package_task'
require 'rake/testtask'
require 'rdoc/task'
require 'bundler/gem_tasks'

$:.push File.expand_path(File.dirname(__FILE__), 'lib')

version = Webhookr::Mailchimp::VERSION

desc 'Test Webhookr Mailchimp'
Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/**/*_tests.rb']
  t.verbose = !!ENV['VERBOSE_TESTS']
  t.warning = !!ENV['WARNINGS']
end

desc 'Build docs'
Rake::RDocTask.new do |t|
  t.main = 'README.md'
  t.title = "Webhookr Mailchimp #{version}"
  t.rdoc_dir = 'doc'
  t.rdoc_files.include('README.md', 'MIT-LICENSE', 'lib/**/*.rb')
end

task :default => :test
