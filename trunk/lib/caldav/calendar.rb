
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
      res = Net::HTTP.start(parsed_uri.host, parsed_uri.port) do |http|
        req = CalDAV::Request::Mkcalendar.new(parsed_uri.path)
        req.basic_auth options[:username], options[:password] unless options[:username].blank? && options[:password].blank?
        req.displayname = options[:displayname]
        req.description = options[:description]
        http.request req
      end
      raise CalDAV::Error.new(res.message, res) if res.code != '201'
      self.new(uri, options)
    end
      
    def delete
      request Net::HTTP::Delete
    end
    
    
    def properties
      request Net::HTTP::Propfind
    end
    
    def add_event(calendar)
      req = returning(prepare_request(Net::HTTP::Put.new("#{uri.path}/#{calendar.events.first.uid}.ics"))) do |req|
        req.add_field "If-None-Match", "*"
        req.body = calendar.to_ical
      end
      res = request req
      raise CalDAV::Error.new(res.message, res) if res.code != '201'
      return true
    end
    
  private
  
    def new_request(clazz, &block)
      returning prepare_request(clazz.new(uri.path)) do |req|
        yield req if block_given?
      end
    end
    
    def prepare_request(req)
      req.basic_auth options[:username], options[:password] unless options[:username].blank? && options[:password].blank?
      req
    end
    
    def request(req)
      req = new_request(req) if req.is_a? Class
      Net::HTTP.start(uri.host, uri.port) do |http|
        http.request req
      end
    end

  end
  
end