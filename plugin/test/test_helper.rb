$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'test/unit'
require 'rubygems'
require 'fake_web'
require 'open-uri'

require 'active_record'
require 'active_record/fixtures'
require File.dirname(__FILE__) + '/../init.rb'

ActiveRecord::Base.configurations = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[ENV['DB'] || 'mysql'])

load(File.dirname(__FILE__) + "/schema.rb")

Test::Unit::TestCase.fixture_path = File.dirname(__FILE__) + "/fixtures/"
$LOAD_PATH.unshift(Test::Unit::TestCase.fixture_path)

require 'user'
require 'course'

class Test::Unit::TestCase #:nodoc:
  def create_fixtures(*table_names)
    if block_given?
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names) { yield }
    else
      Fixtures.create_fixtures(Test::Unit::TestCase.fixture_path, table_names)
    end
  end

  # Turn off transactional fixtures if you're working with MyISAM tables in MySQL
  self.use_transactional_fixtures = true
  
  # Instantiated fixtures are slow, but give you @david where you otherwise would need people(:david)
  self.use_instantiated_fixtures  = false

  # Add more helper methods to be used by all tests here...
  
  
  def assert_accessor(object, *methods)
    methods = methods.first if methods.first.is_a? Hash
    methods.each do |method, value|
      original_value = object.send(method)
      object.send("#{method}=", value || 'test') 
      assert_equal(value || 'test', object.send(method))
      assert_not_equal original_value, object.send(method)
    end
  end
end
