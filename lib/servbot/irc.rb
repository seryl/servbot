require 'eventmachine'

module Servbot
  class IRC < EventMachine::Connection
    include EventMachine::Protocols::LineText2

    attr_accessor :connection
    @@connected = false

    def initialize(options)
      @queue = []
    end

    def self.connect(options)
      @connection = EM.connect(Servbot::Config.server,
                               Servbot::Config.port.to_i,
                               self, options)
    end

    def command(*cmd)
      send_data "#{ cmd.flatten.join(' ') }\r\n"
    end

    def queue(sender, receiver, msg)
      username = sender.split("!").first
      command, *args = msg.split
      Servbot::Bot.run(command, args)
    end

=begin
    def dequeue
      while job = @queue.pop
        sender, cmd = job
        command, *args = cmd.split
        Servbot::Bot.run(command, args)
      end
    end
=end

    def post_init
      EM.add_timer(1) do
        command "USER", [Servbot::Config.username]*4
        command "NICK", Servbot::Config.nickname
      end

      EM.add_timer(3) do
        Servbot::Config.channels.each { |channel|
          command("JOIN", "##{channel}") } if Servbot::Config.channels
      end
    end

    def receive_line(line)
      case line
      when /^PING (.*)/ then command('PONG', $1)
      when /^:(\S+) PRIVMSG (.*) :\!#{ Servbot::Config.nickname } (.*)$/ then queue($1, $2, $3)
      else puts line; end
    end

    def unbind
      EM.add_timer(3) do 
        reconnect(Servbot::Config.server,
                  Servbot::Config.port.to_i)
        post_init
      end
    end

  end
end
