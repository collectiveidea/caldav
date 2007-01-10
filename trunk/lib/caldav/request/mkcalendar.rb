module CalDAV
  module Request
    class Mkcalendar < Net::HTTP::Mkcalendar
      attr_accessor :displayname, :description, :timezone

      def generate_body
        result = ""
        xml = Builder::XmlMarkup.new(:target => result, :indent => 2)
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
              # xml.tag! "cal:calendar-timezone" do
              #   xml.cdata! timezone.to_ical
              # end
            end
          end
        end
        result
      end
      
      def exec(sock, ver, path)
        self.body = generate_body unless @body
        super(sock, ver, path)
      end
      
    end    
  end
end