
module ActiveCalDAV
  
  class NotFound < StandardError
  end
  
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
  
  module IsEvent
    def self.included(base) # :nodoc:
      base.extend ClassMethods
    end
    

    module ClassMethods
      def is_caldav_event(options)
        cattr_accessor :activecaldav_event_options
        self.activecaldav_event_options = options
        attr_accessor :event
        include InstanceMethods
      end
      
    end
  
    module InstanceMethods
      
      def method_missing(method, *args, &block)
        begin
          super(method, *args, &block)
        rescue NoMethodError
          self.caldav_event.send(map_caldav_method(method) || method, *args)
        end
      end

    protected
      
      def map_caldav_method(method)
        mapping = { :begin_at => :dtstart, :end_at => :dtend }
        
        if method.to_s[-1, 1] == "="
          attribute = mapping[method.to_s[0...-1].to_sym]
          attribute ? "#{attribute}=" : nil
        else
          mapping[method.to_sym]
        end
      end
    
      def write_caldav_attribute(attr, value)
        self.caldav_event.send("#{attr}=", value)
      end
      
      def read_caldav_attribute(attr)
        self.caldav_event.send(attr)
      end
    
      def caldav_event
        unless @caldav_event
          @caldav_event = chair.calendar.events(self.activecaldav_uid).first if chair
          if @caldav_event.nil?
            raise ActiveCalDAV::NotFound if self.activecaldav_uid
            @caldav_event = Icalendar::Event.new
          end
        end
        @caldav_event
      end
      
      def chair
        self.send(self.class.activecaldav_event_options[:chair])
      end
    end    
  end
end