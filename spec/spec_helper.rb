require "chingu"
include Chingu
include Gosu

Dir["#{File.dirname(__FILE__)}/../lib/*.rb"].each {|f| require f}

require "rspec"

#RSpec.configure do |config|
#  config.mock_with :rspec
#end
