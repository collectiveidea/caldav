require 'icalendar'

class Icalendar::Event < Icalendar::Component
  attr_writer :caldav
  def caldav
    @caldav ||= {}
  end
end