require File.dirname(__FILE__) + '/../../test_helper.rb'

class EventTest < Test::Unit::TestCase 
  
  def test_caldav_accessors
    event = Icalendar::Event.new
    
    assert_respond_to event, 'caldav'
    assert_respond_to event, 'caldav='    
    
    assert_kind_of Hash, event.caldav
    
    keys = [:etag, :href]
    keys.each do |method|
      assert_nil event.caldav[method]
      event.caldav[method] = 'e'
      assert_equal('e', event.caldav[method])
    end
  end
  
end