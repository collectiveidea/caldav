class User < ActiveRecord::Base
  has_caldav_calendar "http://example.com/calendars/users/:name/calendar",
    :username => :name, :password => "chavez"
end