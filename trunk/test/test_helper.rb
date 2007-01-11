$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__) + '/mocks')

require 'rubygems'
require 'test/unit'
require 'breakpoint'
require 'caldav'

class Test::Unit::TestCase
  
private
  
  def prepare_response(test_name, response_name)
    Net::HTTP.responses << File.read(File.join(File.dirname(__FILE__), 'responses', test_name, "#{response_name}.txt"))
  end
  
  def assert_request(test_name, request_name)
    assert !Net::HTTP.requests.empty?, "No requests were made"
    expected = File.read(File.join(File.dirname(__FILE__), 'requests', test_name, "#{request_name}.txt")).split("\n")
    actual = Net::HTTP.requests.shift.split("\n")
    assert_match Regexp.new(expected.first.chomp), actual.first.chomp
    1.upto(expected.size) do |i|
      expected_value = expected[i] ? expected[i].chomp : nil
      actual_value = actual[i] ? actual[i].chomp : nil
      assert_equal expected_value, actual_value
    end
  end
  
  def assert_request_body(path, request)
    file = File.read(File.join(File.dirname(__FILE__), 'requests', *path ))
    assert_not_nil request.generate_body
    assert_equal REXML::Document.new(file, :compress_whitespace => :all, :ignore_whitespace_nodes => :all).to_s, REXML::Document.new(request.generate_body, :compress_whitespace => :all, :ignore_whitespace_nodes => :all).to_s
  end
  
end