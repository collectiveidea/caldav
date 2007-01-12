require File.dirname(__FILE__) + '/test_helper'

class CaldavTest < Test::Unit::TestCase
  
  def setup
    @uri = URI.parse("http://example.com/calendars/users/jim/calendar")
    @user = User.new(:name => "jim")
  end

  def test_has_caldav_calendar_declaration_adds_calendar
    assert_kind_of CalDAV::Calendar, User.new().calendar
  end
  
  def test_sets_calendar_uri
    assert_equal @uri, @user.calendar.uri
  end
  
  def test_sets_username_and_password
    assert_equal "jim", @user.calendar.options[:username]
    assert_equal "chavez", @user.calendar.options[:password]
  end
end
