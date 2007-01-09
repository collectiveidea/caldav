

module Icalendar
  class Timezone
    
    def self.from_tzinfo(timezone)
      returning self.new do |result|
        result.tzid = timezone.identifier
        result.add_component returning(Standard.new) do |standard|
        end
      end
    end
    
  end
end