class User < ActiveRecord::Base
  has_caldav_calendar "http://localhost:8008/calendars/users/:name/calendar",
    :username => :name, :password => "admin"
  
  has_many :courses
end