
require 'rubygems'
require 'builder'
require 'active_support'
require 'icalendar'
require 'tzinfo'
require 'net/http'
require File.join(File.dirname(__FILE__), 'extensions', 'net', 'http.rb')
require File.join(File.dirname(__FILE__), 'extensions', 'icalendar', 'timezone.rb')

Dir[File.join(File.dirname(__FILE__), 'caldav/**/*.rb')].sort.each { |lib| require lib }

