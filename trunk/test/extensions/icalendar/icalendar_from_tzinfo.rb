require File.dirname(__FILE__) + '/../../test_helper.rb'

class Net::HTTPTest < Test::Unit::TestCase
  
  def setup
    @tz = Icalendar::Timezone.from_tzinfo(TZInfo::Timezone.new("America/Detroit"))
  end

  def test_returns_icalendar_timezone
    assert_equal Icalendar::Timezone, @tz.class
  end
  
  def test_sets_tzid
    assert_equal "America/Detroit", @tz.tzid
  end
  
  def test_adds_standard_component
    assert !@tz.instance_variable_get("@components").empty?
    assert_kind_of Icalendar::Standard, @tz.instance_variable_get("@components")[:standard]
  end
  
end
