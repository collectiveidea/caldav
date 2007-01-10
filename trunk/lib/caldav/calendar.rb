module CalDAV
  
  class Calendar
    attr_accessor :uri, :options
    
    def initialize(uri, options = {})
      self.uri = URI.parse(uri)
      self.options = options
    end
    
    # Create a new calendar
    #
    # == Options
    #
    # * <tt>:displayname</tt>: A display name for the calendar
    # * <tt>:description</tt>: A description for the calendar
    # * <tt>:username</tt>: Username used for authentication
    # * <tt>:password</tt>: Password used for authentication
    #
    def self.create(uri, options = {})
      parsed_uri = URI.parse(uri)
      response = Net::HTTP.start(parsed_uri.host, parsed_uri.port) do |http|
        request = CalDAV::Request::Mkcalendar.new(parsed_uri.path)
        request.basic_auth options[:username], options[:password] unless options[:username].blank? && options[:password].blank?
        request.displayname = options[:displayname]
        request.description = options[:description]
        http.request request
      end
      raise CalDAV::Error.new(response.message, response) if response.code != '201'
      self.new(uri, options)
    end
      
    def delete
      perform_request Net::HTTP::Delete
    end
    
    
    def properties
      perform_request Net::HTTP::Propfind
    end
    
    def add_event(calendar)
      request = prepare_request(Net::HTTP::Put.new("#{uri.path}/#{calendar.events.first.uid}.ics"))
      request.add_field "If-None-Match", "*"
      request.body = calendar.to_ical
      response = perform_request request
      raise CalDAV::Error.new(response.message, response) if response.code != '201'
      true
    end
    
    def events
      events = []
      
      file = File.read(File.dirname(__FILE__)+'/../../test/responses/calendar/events.txt')
      file.split("\n").slice(5..-1).join("\n")
      
      body = REXML::Document.new(file)
      body.root.add_namespace 'dav', 'DAV:'
      body.root.add_namespace 'caldav', 'urn:ietf:params:xml:ns:caldav'

      body.elements.each("dav:multistatus/dav:response") do |element|
        calendar = Icalendar::Parser.new(element.elements["dav:propstat/dav:prop/caldav:calendar-data"].text).parse.first
        calendar.events.each do |event|
          event.caldav = {
            :etag => element.elements["dav:propstat/dav:prop/dav:getetag"].text, 
            :href => element.elements["dav:href"].text
          }
        events += calendar.events
        end
      end
      
      events
    end
    
  private
  
    def new_request(clazz, &block)
      returning prepare_request(clazz.new(uri.path)) do |request|
        yield request if block_given?
      end
    end
    
    def prepare_request(request)
      request.basic_auth options[:username], options[:password] unless options[:username].blank? && options[:password].blank?
      request
    end
    
    def perform_request(request)
      request = new_request(request) if request.is_a? Class
      Net::HTTP.start(uri.host, uri.port) do |http|
        http.request request
      end
    end

  end
end