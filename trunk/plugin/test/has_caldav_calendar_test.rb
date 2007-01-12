require File.dirname(__FILE__) + '/test_helper'

class CaldavTest < Test::Unit::TestCase
  
  def setup
    @uri = URI.parse("http://localhost:8008/calendars/users/admin/calendar")
    @user = User.new(:name => "admin")
  end

  def test_has_caldav_calendar_declaration_adds_calendar
    assert_kind_of CalDAV::Calendar, User.new().calendar
  end
  
  def test_sets_calendar_uri
    assert_equal @uri, @user.calendar.uri
  end
  
  def test_sets_username_and_password
    assert_equal "admin", @user.calendar.options[:username]
    assert_equal "admin", @user.calendar.options[:password]
  end
end
