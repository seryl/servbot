require 'eventmachine'

module Servbot
  class IRC < EventMachine::Connection
    include EventMachine::Protocols::LineText2

    attr_accessor :connection

    def self.connect(options)
      @connection = EM.connect(Servbot::Config.server,
                               Servbot::Config.port.to_i,
                               self, options)
    end

    def receive_line(line)
      puts line
    end

    #def unbind
    #end

  end
end
