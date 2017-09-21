# source http://www.rubydoc.info/gems/rspec-core/RSpec/Core/RakeTask
require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:test) do |t|
  ruby 'spec/test_helper.rb'
  t.pattern = Dir.glob('spec/**/*_spec.rb')
end
