module CalDAV
  module Filter
    class Property < Base
      attr_accessor :name, :text
      
      def initialize(name, text, parent = nil)
        self.name = name
        self.text = text
        self.parent = parent
      end
      
      def build_xml(xml)
        xml.tag! "cal:prop-filter", :name => self.name do
          xml.tag! "cal:text-match", self.text, :collation => "i;octet"
        end
      end
    end
  end
end