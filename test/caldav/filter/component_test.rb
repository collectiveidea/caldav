require File.dirname(__FILE__) + '/../../test_helper.rb'

class ComponentTest < Test::Unit::TestCase
  
  def setup
    @filter = CalDAV::Filter::Component.new("name")
  end
  
  def test_accessors
    assert_accessor @filter, 
      :parent => CalDAV::Filter::Base.new,
      :child => CalDAV::Filter::Base.new, 
      :name => "test"
  end
  
  def test_initialize
    parent = CalDAV::Filter::Base.new
    new_component = CalDAV::Filter::Component.new('new name', parent)
    assert_equal('new name', new_component.name)
    assert_equal(parent, new_component.parent)
  end
  
  def test_time_range
    assert_nil @filter.child
    time_range = @filter.time_range(nil)
    assert_kind_of CalDAV::Filter::TimeRange, time_range
    assert_equal time_range, @filter.child
  end
  
  def test_uid
    assert_nil @filter.child
    uid = @filter.uid(nil)
    assert_kind_of CalDAV::Filter::Property, uid
    assert_equal uid, @filter.child
  end
  
  def test_build_xml_without_child
    @filter.name = 'hello'
    xml = REXML::Document.new(@filter.to_xml)
    assert_kind_of REXML::Element, REXML::XPath.match( xml, "cal:comp-filter[@name='hello']").first
  end
  
  def test_build_xml_with_child
    @filter.name = 'hello'
    @filter.child = CalDAV::Filter::Component.new('child name')
    xml = REXML::Document.new(@filter.to_xml)
    child_xml = REXML::XPath.match( xml, "cal:comp-filter[@name='hello']").first
    assert_kind_of REXML::Element, child_xml
    assert !xml.root.elements.empty?
  end
end