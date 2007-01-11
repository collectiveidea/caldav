require File.dirname(__FILE__) + '/../../test_helper.rb'

class TimeRangeTest < Test::Unit::TestCase
  
  def setup
    @start = Date.new(2006, 1, 1)
    @end = Date.new(2006, 12, 31)
    @filter = CalDAV::Filter::TimeRange.new(@start..@end)
  end
  
  def test_initialize_sets_range
    assert_equal @start..@end, @filter.range
  end
  
  def test_to_xml
    # FIXME: parse XML and compare using xpath
    assert_match /^<\w*:time\-range start="#{@start.to_ical}" end="#{@end.to_ical}"\/>$/, @filter.to_xml.chomp
  end
  
end