module CalDAV
  module Filter
    class Base
      attr_accessor :parent, :child
      
      def to_xml(xml = Builder::XmlMarkup.new(:indent => 2))
        if parent
          parent.to_xml
        else
          build_xml(xml)
        end
      end
      
      def build_xml(xml)
        #do nothing
      end
      
      def child=(child)
        @child = child
        child.parent = self
      end
    end
  end
end