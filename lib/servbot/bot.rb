require 'pp'

class Servbot::Bot
  attr_accessor :connected, :commands

  include Servbot::Plugins

  def initialize
    @connected = false
    @commands = {}

    if File.exists?(Servbot::Const::CONFIG_FILE)
      Servbot::Config.from_file(Servbot::Const::CONFIG_FILE)
    end
    
    trap("TERM") { EM.stop; exit(0) }
    trap("INT") { EM.stop; exit(0) }

    EM.run do
      load_plugins
      @commands["hello"] = lambda { |*args| puts args.join(" ") }
      Servbot::IRC.connect(nil)
    end
  end

  def load_config
  end
  
  def self.run(command, args)
    proc = @commands[command]
    proc ? proc.call(args) : (puts "command #{command} not found. ")
  end
  
  def clear_commands
    @commands = {}
  end
  
  def add_command(command, proc)
    @commands[command] = proc
  end
  
end
