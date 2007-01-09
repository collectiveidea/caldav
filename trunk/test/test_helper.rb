$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__) + '/mocks')

require 'rubygems'
require 'test/unit'
require 'breakpoint'
require 'caldav'
require 'mocha'
require 'stubba'


class Test::Unit::TestCase
  
private
  
  def response(test_name, response_name)
    Net::HTTP.responses << File.read(File.join(File.dirname(__FILE__), 'responses', test_name, "#{response_name}.txt"))
  end
  
end