$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__) + '/mocks')

require 'rubygems'
require 'test/unit'
require 'breakpoint'
require 'caldav'

class Test::Unit::TestCase
  
private
  
  def response(test_name, response_name)
    Net::HTTP.responses << File.read(File.join(File.dirname(__FILE__), 'responses', test_name, "#{response_name}.txt"))
  end
  
  def assert_request(test_name, request_name)
    expected = File.read(File.join(File.dirname(__FILE__), 'requests', test_name, "#{request_name}.txt")).split("\n")
    actual = Net::HTTP.requests.shift.split("\n")
    assert_match Regexp.new(expected.first.chomp), actual.first.chomp
    1.upto(expected.size) do |i|
      expected_value = expected[i] ? expected[i].chomp : nil
      actual_value = actual[i] ? actual[i].chomp : nil
      assert_equal expected_value, actual_value
    end
  end

end