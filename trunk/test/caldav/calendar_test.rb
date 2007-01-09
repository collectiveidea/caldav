require File.dirname(__FILE__) + '/../test_helper.rb'

#require 'http'

class CalendarTest < Test::Unit::TestCase
  
  def setup
    @uri = "http://example.com/calendars/users/foo"
  end
  
  def test_create
    CalDAV::Calendar.create(@uri)
  end
  
end