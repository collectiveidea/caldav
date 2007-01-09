module CalDAV
  
  class Mkcalendar < Net::HTTP::Mkcalendar
    attr_accessor :displayname, :description, :timezone
    # def initialize(path, displayname = nil, description = nil, timezone = nil, initheader = nil)
    #   super(path, initheader)
    #   self.body = mkcalendar_body(name, description, timezone)
    # end
    # 
    def body
      result = ""
      xml = Builder::XmlMarkup.new(:target => result)
      namespaces = { "xmlns:dav" => 'DAV:', "xmlns:cal" => "urn:ietf:params:xml:ns:caldav" }

      xml.instruct!
      xml.tag! "cal:mkcalendar", namespaces do
        xml.tag! "dav:set" do
          xml.tag! "dav:prop" do
            xml.tag! "dav:displayname", displayname unless displayname.blank?
            xml.tag! "cal:calendar-description", description, "xml:lang" => "en" unless description.blank?            # 
            # xml.tag! "cal:supported-calendar-component-set" do
            #   xml.tag! "cal:comp", :name => "VEVENT"
            # end
            xml.tag! "cal:calendar-timezone" do
              xml.cdata! timezone.to_ical
            end
          end
        end
      end
      
      result
    end
    
  end
end