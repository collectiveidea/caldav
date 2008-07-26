require File.dirname(__FILE__) + '/../test_helper.rb'

class CalendarQueryTest < Test::Unit::TestCase 
  
  def test_event_without_param
    event = CalDAV::CalendarQuery.new.event
    assert_kind_of CalDAV::Filter::Component, event
    assert_equal 'VEVENT', event.name
  end
  
  def test_event_with_range
    timerange_query = CalDAV::CalendarQuery.new.event(1..2)
    assert_kind_of CalDAV::Filter::TimeRange, timerange_query
    assert_kind_of CalDAV::Filter::Component, timerange_query.parent
    assert_nil timerange_query.child
    
    assert_equal 1..2, timerange_query.range
  end
  
  def test_build_xml_with_event
    query = CalDAV::CalendarQuery.new.event()
    xml = REXML::Document.new(query.to_xml)
    assert_kind_of REXML::Element, REXML::XPath.match(xml, "cal:calendar-query/dav:prop/dav:getetag").first
    assert_kind_of REXML::Element, REXML::XPath.match(xml, "cal:calendar-query/dav:prop/cal:calendar-data").first
    assert !REXML::XPath.match(xml, "cal:calendar-query/cal:filter").first.elements.empty?
  end
  
end