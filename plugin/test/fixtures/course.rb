class Course < ActiveRecord::Base
  is_caldav_event :chair => :user
  
  belongs_to :user
end