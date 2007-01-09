require File.dirname(__FILE__) + '/../../test_helper.rb'

class Net::HTTPTest < Test::Unit::TestCase

  def test_mkcalendar
    assert_equal 'MKCALENDAR', Net::HTTP::Mkcalendar::METHOD
    assert Net::HTTP::Mkcalendar::REQUEST_HAS_BODY
    assert Net::HTTP::Mkcalendar::RESPONSE_HAS_BODY
  end
  
  def test_report
    assert_equal 'REPORT', Net::HTTP::Report::METHOD
    assert Net::HTTP::Mkcalendar::REQUEST_HAS_BODY
    assert Net::HTTP::Mkcalendar::RESPONSE_HAS_BODY
  end
  
end
