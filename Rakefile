require 'rubygems'
require 'hoe'
require File.join(File.dirname(__FILE__), 'lib', 'caldav', 'version')

RDOC_OPTS = ['--quiet', '--title', "caldav documentation",
    "--opname", "index.html",
    "--line-numbers", 
    "--main", "README",
    "--inline-source"]

# Generate all the Rake tasks
hoe = Hoe.new('caldav', ENV['VERSION'] || CalDAV::VERSION::STRING) do |p|
  p.rubyforge_name = 'caldav'
  p.summary = "A Ruby CalDAV client."
  p.description = "A Ruby CalDAV client."
  p.author = ['Brandon Keepers', 'John Hwang', 'Daniel Morrison'] 
  p.email = 'brandon@opensoul.org'
  p.url = 'http://caldav.rubyforge.org'
  p.test_globs = ["test/**/*_test.rb"]
  p.changes = p.paragraphs_of('CHANGELOG.txt', 0..1).join("\n\n")
  p.extra_deps << ['activesupport']
  p.extra_deps << ['tzinfo']
  p.extra_deps << ['builder']
  p.extra_deps << ['icalendar']
end

require 'rcov/rcovtask'

namespace :test do 
  namespace :coverage do
    desc "Delete aggregate coverage data."
    task(:clean) { rm_f "coverage.data" }
  end
  desc 'Aggregate code coverage for unit, functional and integration tests'
  task :coverage => "test:coverage:clean"
  %w[unit functional integration].each do |target|
    namespace :coverage do
      Rcov::RcovTask.new(target) do |t|
        t.libs << "test"
        t.test_files = FileList["test/#{target}/*_test.rb"]
        t.output_dir = "test/coverage/#{target}"
        t.verbose = true
        t.rcov_opts << '--rails --aggregate coverage.data'
      end
    end
    task :coverage => "test:coverage:#{target}"
  end
end
