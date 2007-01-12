require File.dirname(__FILE__) + '/test_helper'

class IsCalDAVEventTest < Test::Unit::TestCase
  fixtures :courses, :users

  def setup
  end
  
  def test_adds_event_options
    assert_kind_of Hash, Course.activecaldav_event_options
  end
  
  def test_user_has_calendar
    course = Course.find(courses(:first).id)
    
    assert_kind_of Icalendar::Event, course.instance_variable_get("@caldav_event")
  end
  
end