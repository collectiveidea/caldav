require File.dirname(__FILE__) + '/test_helper'

class IsCalDAVEventTest < Test::Unit::TestCase
  fixtures :courses, :users

  def setup
  end
  
  def test_adds_event_options
    assert_kind_of Hash, Course.activecaldav_event_options
  end
  
  def test_course_has_caldav_event
    @course = Course.find(courses(:first).id)
    mock_response(@course, 'course_event')
    assert_kind_of Icalendar::Event, @course.send(:caldav_event)
    assert_kind_of Icalendar::Event, @course.instance_variable_get("@caldav_event")
  end

  def test_course_with_uid_but_no_course_found
    @course = Course.find(courses(:first).id)
    mock_response(@course, 'empty_report')
    assert_raise(ActiveCalDAV::NotFound) do
      assert_kind_of Icalendar::Event, @course.send(:caldav_event)
    end
  end

  def test_course_has_new_caldav_event_if_nil
    @course = Course.find(courses(:without_uid).id)
    mock_response(@course, 'empty_report')
    assert_kind_of Icalendar::Event, @course.send(:caldav_event)
    assert_kind_of Icalendar::Event, @course.instance_variable_get("@caldav_event")
  end
  
  def test_caldav_accessor_from_mock_response
    @course = Course.find(courses(:first).id)
    mock_response(@course, 'course_event')
    expected = DateTime.parse("20060102T120000")
    assert_equal expected, @course.begin_at, 
      "#{expected.strftime('%c')} expected but was #{@course.begin_at.strftime('%c')}"
      
    new_value = DateTime.parse("20060102T120002")
    @course.begin_at = new_value
    assert_equal new_value, @course.begin_at
  end
  
  def test_caldav_accessors
    @course = Course.find(courses(:first).id)
    mock_response(@course, 'course_event')
    
    accessors = {
      :begin_at => DateTime.parse("20070102T120000"), 
      :end_at => DateTime.parse("20080102T120000")
    }
    assert_accessor @course, accessors
  end
  
private
  
  def mock_response(course, response)
    response = File.read(File.join(File.dirname(__FILE__), 'responses', "#{response}.txt"))
    FakeWeb.register_uri(course.user.calendar.uri.to_s, :response => response)
  end
  
end