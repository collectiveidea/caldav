module CalDAV
  module Request
    class Report < Net::HTTP::Report
      attr_accessor :time_range

      def generate_body
        result = ""
        xml = Builder::XmlMarkup.new(:target => result, :indent => 2)
        namespaces = { "xmlns:dav" => 'DAV:', "xmlns:cal" => "urn:ietf:params:xml:ns:caldav" }

        xml.instruct!
        xml.tag! "cal:calendar-query", namespaces do
          xml.tag! "dav:prop" do
            xml.tag! "dav:getetag"
            xml.tag! "cal:calendar-data"
          end
          xml.tag! "cal:filter" do
            xml.tag! "cal:comp-filter", :name => "VCALENDAR" do
              xml.tag! "cal:comp-filter",  :name => "VEVENT" do
                xml.tag! "cal:time-range",
                  :start => time_range.begin.to_ical(true),
                  :end => time_range.end.to_ical(true)
              end
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