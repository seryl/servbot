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

    def command(*cmd)
      send_data "#{ cmd.flatten.join(' ') }\r\n"
    end

    def post_init
      command "USER", [Servbot::Config.username]*4
      command "NICK", Servbot::Config.nickname
      command("NickServ IDENTIFY", Servbot::Config.username,
              Servbot::Config.password) if Servbot::Config.password

      Servbot::Config.channels.each { |channel|
        command("JOIN", "##{channel}") } if Servbot::Config.channels
    end

    def receive_line(line)
      puts line
    end

    #def unbind
    #end

  end
end
