$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__) + '/mocks')

require 'test/unit'
require 'caldav'
require 'mocha'
require 'stubba'
