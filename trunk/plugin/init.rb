require 'caldav'
require 'activecaldav'

ActiveRecord::Base.send :include, ActiveCalDAV::HasCalendar
