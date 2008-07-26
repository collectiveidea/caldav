module CalDAV
  module Filter
    class Component < Base
      attr_accessor :name
      
      def initialize(name, parent = nil)
        self.name = name
        self.parent = parent
      end
      
      def time_range(range)
        self.child = TimeRange.new(range, self)
      end
      
      def uid(uid)
        self.child = Property.new("UID", uid, self)
      end
      
      def build_xml(xml)
        xml.tag! "cal:comp-filter", :name => name do
          child.build_xml(xml) unless child.blank? 
        end
      end
    end
  end
end