require File.dirname(__FILE__) + '/../../test_helper.rb'

class MkcalendarTest < Test::Unit::TestCase
  
  def setup
    @uri = URI.parse("http://example.com/calendar/test")
    @request = CalDAV::Request::Mkcalendar.new(@uri.path)    
  end
  
  def test_displayname
    assert_nil @request.displayname
    @request.displayname = 'My Fancy New Calendar'
    assert_equal 'My Fancy New Calendar', @request.displayname
  end
  
  def test_description
    assert_nil @request.description
    @request.description = 'About My Fancy New Calendar'
    assert_equal 'About My Fancy New Calendar', @request.description
  end
  
  def test_timezone
    assert_nil @request.timezone
    @request.timezone = 'This is a timezone'
    assert_equal 'This is a timezone', @request.timezone
  end
  
  def test_body_without_data
    assert_request_file(['mkcalendar', 'success_empty_body.xml'], @request)
  end
  
  def test_body_with_only_displayname
    @request.displayname = "A New Calendar"
    assert_request_file(['mkcalendar', 'success_only_displayname.xml'], @request)
  end
  
  def test_body_with_only_description
    @request.description = "A description for a new calendar"
    assert_request_file(['mkcalendar', 'success_only_description.xml'], @request)
  end
  
protected

  def assert_request_file(path, request)
    path = File.join(File.dirname(__FILE__), '..', '..', 'requests', *path )
    file = File.read(path)
    assert_not_nil request.generate_body
    assert_equal REXML::Document.new(file, :compress_whitespace => :all, :ignore_whitespace_nodes => :all).to_s, REXML::Document.new(request.generate_body, :compress_whitespace => :all, :ignore_whitespace_nodes => :all).to_s
  end

end