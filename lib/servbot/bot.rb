class Servbot::Bot
  attr_accessor :connected, :commands

  include Servbot::Plugins

  def initialize
    @connected = false
    @commands = {}

    trap("TERM") { EM.stop; exit(0) }
    trap("INT")  { EM.stop; exit(0) }
    Servbot::Config.load_config
    start_loop
  end

  def start_loop
    EM.run do
      load_plugins
      add_command "hello", lambda { |*args| puts args.join(" ") }
      @irc = Servbot::IRC.connect(nil)
      @irc.add_observer(self)
    end
  end

  def clear_commands
    @commands = {}
  end
  
  def add_command(command, proc)
    @commands[command] = proc
  end
  
  def run(command, args)
    proc = @commands[command]
    proc ? proc.call(args) : (puts "command #{command} not found. ")
  end

  def update(time, username, command, args)
    run command, args
  end

end
