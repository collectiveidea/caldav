require File.dirname(__FILE__) + '/../../test_helper.rb'

class PropertyTest < Test::Unit::TestCase
  
  def setup
    @filter = CalDAV::Filter::Property.new("property-name", "property-value")
  end
  
  def test_accessors
    assert_accessor @filter, :name, :text
  end
  
  def test_initialize
    parent = CalDAV::Filter::Base.new
    property = CalDAV::Filter::Property.new("property-name", "property-value", parent)
    assert_equal('property-name', property.name)
    assert_equal(parent, property.parent)
  end
  
  def test_build_xml
    xml = REXML::Document.new(@filter.to_xml)
    result = REXML::XPath.match( xml, "cal:prop-filter[@name='property-name']/cal:text-match").first
    assert_kind_of REXML::Element, result
    assert_equal 'property-value', result.text
  end
end