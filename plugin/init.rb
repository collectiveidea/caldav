require 'caldav'
require 'activecaldav'

ActiveRecord::Base.send :include, ActiveCalDAV::HasCalendar
ActiveRecord::Base.send :include, ActiveCalDAV::IsEvent
