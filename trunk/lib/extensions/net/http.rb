module Net #:nodoc:
  class HTTP #:nodoc:
    
    class Mkcalendar < HTTPRequest
      METHOD = 'MKCALENDAR'
      REQUEST_HAS_BODY = true
      RESPONSE_HAS_BODY = true
    end
    
    class Report < HTTPRequest
      METHOD = 'REPORT'
      REQUEST_HAS_BODY = true
      RESPONSE_HAS_BODY = true
    end
    
  end
end