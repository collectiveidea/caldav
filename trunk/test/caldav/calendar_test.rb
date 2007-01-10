require File.dirname(__FILE__) + '/../test_helper.rb'

require 'http'

class CalendarTest < Test::Unit::TestCase
  
  def setup
    @uri = "http://example.com/calendars/users/admin/newcal/"
    @username = "admin"
    @password = "password"
    @calendar = CalDAV::Calendar.new(@uri, :username => @username, :password => @password)
    Net::HTTP.responses = []
    Net::HTTP.requests = []
  end
  
  def test_create
    response('calendar', 'success')
    cal = CalDAV::Calendar.create(@uri, :username => @username, :password => @password,
      :displayname => "New Calendar", :description => "Calendar Description")
    assert_request 'calendar', 'create'
    assert_kind_of CalDAV::Calendar, cal
  end
  
  def test_unauthorized_failure_on_create
    response('calendar', '401_Unauthorized')
    begin
      cal = CalDAV::Calendar.create(@uri,
        :displayname => "New Calendar", :description => "Calendar Description")
    rescue CalDAV::Error => error
      assert_request 'calendar', 'create_without_credentials'
      assert_kind_of Net::HTTPResponse, error.response
      assert_equal '401', error.response.code
    rescue
      fail "Should raise CalDAV::Error"
    end
  end
  
  def test_add_event
    response('calendar', 'success')
    @cal = Icalendar::Calendar.new
    @cal.event do
      dtstart 174740
      summary "Playing with CalDAV"
      dtend 184740
      dtstamp '20070109T174740'
      uid 'UID'
    end
    assert @calendar.add_event(@cal)
    assert_request 'calendar', 'add_event'
  end
  
end