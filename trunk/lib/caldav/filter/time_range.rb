module CalDAV
  module Filter
    class TimeRange < Base
      attr_accessor :range
      
      def initialize(range, parent = nil)
        self.range = range
        self.parent = parent
      end
      
      def build_xml(xml)
        xml.tag! "cal:time-range",
          :start => range.begin.to_ical(true),
          :end => range.end.to_ical(true)
      end
    end
  end
end