require File.dirname(__FILE__) + '/../../test_helper.rb'

class CalDAV::Filter::BaseTest < Test::Unit::TestCase
  
  def setup
    @start = Date.new(2006, 1, 1)
    @end = Date.new(2006, 12, 31)
    @filter = CalDAV::Filter::Base.new
  end
  
  def test_accessors
    assert_accessor @filter, :parent => CalDAV::Filter::Base.new, :child => CalDAV::Filter::Base.new
  end
  
  def test_to_xml_without_parent
    @filter.expects(:build_xml).with('foo').returns('foobar')
    assert_respond_to @filter, :to_xml
    assert_equal 'foobar', @filter.to_xml('foo')
  end
  
  def test_to_xml_with_parent
    parent = CalDAV::Filter::Base.new
    parent.expects(:build_xml).with('bar').returns('barbaz')
    
    @filter.parent = parent
    assert_respond_to @filter, :to_xml
    assert_equal 'barbaz', @filter.to_xml('bar')
  end
  
  def test_child=
    @filter.child = CalDAV::Filter::Base.new
    assert_equal @filter, @filter.child.parent
  end
end