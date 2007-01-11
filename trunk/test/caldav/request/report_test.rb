require File.dirname(__FILE__) + '/../../test_helper.rb'

class ReportTest < Test::Unit::TestCase
  
  def setup
    @uri = URI.parse("http://example.com/calendar/test")
    @request = CalDAV::Request::Report.new(@uri.path)    
  end
  
  def test_extends_net_http_report
    assert_kind_of Net::HTTP::Report, @request
  end
  
  def test_time_range
    assert_nil @request.time_range
    @request.time_range = DateTime.parse("20060102T000000Z")..DateTime.parse("20060103T000000Z")
    assert_not_nil @request.time_range
    assert_request_body ['report', 'time_range.xml'], @request
  end
  
end