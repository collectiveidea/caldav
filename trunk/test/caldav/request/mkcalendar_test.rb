require File.dirname(__FILE__) + '/../../test_helper.rb'

class MkcalendarTest < Test::Unit::TestCase
  
  def setup
    @request = CalDAV::Request::Mkcalendar.new    
  end
  
  def test_displayname
    @request = CalDAV::Request::Mkcalendar.new('My Fancy New Calendar')
    assert_equal 'My Fancy New Calendar', @request.displayname
  end
  
  def test_description
    @request = CalDAV::Request::Mkcalendar.new(nil, 'About My Fancy New Calendar')
    assert_equal 'About My Fancy New Calendar', @request.description
  end
  
  def test_body_without_data
    assert_request_body(['mkcalendar', 'success_empty_body.xml'], @request.to_xml)
  end
  
  def test_body_with_only_displayname
    @request.displayname = "A New Calendar"
    assert_request_body(['mkcalendar', 'success_only_displayname.xml'], @request.to_xml)
  end
  
  def test_body_with_only_description
    @request.description = "A description for a new calendar"
    assert_request_body(['mkcalendar', 'success_only_description.xml'], @request.to_xml)
  end

end