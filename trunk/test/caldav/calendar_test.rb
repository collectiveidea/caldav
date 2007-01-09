require File.dirname(__FILE__) + '/../test_helper.rb'

require 'http'

class CalendarTest < Test::Unit::TestCase
  
  def setup
    @uri = "http://example.com/calendars/users/foo"
  end
  
  def test_create
    response('calendar', 'success')
    cal = CalDAV::Calendar.create(@uri)
    assert_kind_of CalDAV::Calendar, cal
  end
  
  def test_unauthorized_failure_on_create
    response('calendar', '401_Unauthorized')
    begin
      CalDAV::Calendar.create(@uri)
    rescue CalDAV::Error => error
      assert_kind_of Net::HTTPResponse, error.response
      assert_equal '401', error.response.code
    rescue
      fail "Should raise CalDAV::Error"
    end
  end
  
  def test_add_event
    response('calendar', 'success')
    calendar = Icalendar::Calendar.new
    calendar.event do
      dtstart Time.now
      summary "Playing with CalDAV"
      dtend 1.hour.from_now
    end
    assert CalDAV::Calendar.new(@uri).add_event(calendar)
  end
  
end