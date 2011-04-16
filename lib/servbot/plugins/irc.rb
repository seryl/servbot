$LOAD_PATH.unshift File.dirname(__FILE__) + '/../../lib'
require 'servbot/events'
require 'observer'
begin
  require 'eventmachine'
rescue LoadError
  require 'rubygems'
  require 'eventmachine'
end

class Servbot::Plugins::IRC < EventMachine::Connection
  include Observable
  include EventMachine::Protocols::LineText2

  attr_accessor :connection

  def self.connect(options)
    @connection = EM.connect(Servbot::Config.server,
                             Servbot::Config.port.to_i,
                             self, options)
  end

  def command(*cmd)
    send_data "#{ cmd.flatten.join(' ') }\n"
  end

  def notify(sender, receiver, msg)
    username = sender.split("!").first
    command, *args = msg.split
    changed             # notifiy observers
    notify_observers(Time.now, username, command, args)
  end

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
    when /^:(\S+) PRIVMSG (.*) :\!(.*)$/
    then # Log message?
      notify($1, $2, $3)
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
