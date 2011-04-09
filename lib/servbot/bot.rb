require 'eventmachine'
require 'servbot/const'

module Servbot
  class Bot
    def initialize
      if File.exists?(Servbot::Const::CONFIG_FILE)
        Servbot::Config.from_file(Servbot::Const::CONFIG_FILE)
      end
    end

    def connect
      begin
        if defined?(EventMachine::fork_reactor)
          pid = EventMachine::fork_reactor {
            begin
              #self.connection = EventMachine::connect()
            rescue
            end
          }
        end
      rescue
      end
    end

  end
end
