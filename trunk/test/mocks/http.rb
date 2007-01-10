require 'net/http'
require 'net/protocol'

module Net
  class HTTP < Protocol
    cattr_accessor :requests, :responses
    self.requests = []
    self.responses = []
    
    attr_accessor :socket
    
    alias original_connect connect
    def connect
      @socket = BufferedIO.new(StringIO.new(self.class.responses.shift))
      on_connect
    end
    
  end
  
  class BufferedIO
    attr_accessor :response
    
    def initialize(io)
      @response = io
      @io = StringIO.new
      @read_timeout = 60
      @debug_output = nil
      @rbuf = ''
    end
    
    alias original_close close
    def close
      Net::HTTP.requests << @io.string
      original_close
    end
    
  private

  def rbuf_fill
    timeout(@read_timeout) {
      @rbuf << @response.sysread(1024)
    }
  end
    
    
  end
end