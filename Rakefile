require 'rspec/core/rake_task'

task :default => :run

desc "Run tests on Connect four game"
RSpec::Core::RakeTask.new(:spec) do |t|
	t.rspec_opts = "-c -w -f documentation"
	t.verbose = false
end
