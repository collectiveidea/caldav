
module ActiveCalDAV
  module HasCalendar
    def self.included(base) # :nodoc:
      base.extend ClassMethods
    end

    module ClassMethods
      def has_caldav_calendar(uri, options)
        cattr_accessor :activecaldav_uri, :activecaldav_options
        self.activecaldav_uri = uri
        self.activecaldav_options = options
        include InstanceMethods
      end
    end
  
    module InstanceMethods
      def calendar
        @calendar ||= CalDAV::Calendar.new(calendar_uri, caldav_options)
      end
      
    private
      
      def calendar_uri
        returning self.class.activecaldav_uri.dup do |uri|
          named_params = /\/:(\w+)\//.match(uri)
          if named_params
            named_params.captures.each do |attr|
              uri.gsub!(":#{attr}", "#{self.send(attr)}")
            end
          end
        end
      end
      
      def caldav_options
        returning self.class.activecaldav_options.dup do |options|
          options.each do |k,v|
            options[k] = self.send(v) if v.is_a? Symbol
          end
        end
      end
      
    end
  end
end