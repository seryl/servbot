class Servbot::Bot
  attr_accessor :commands

  include Servbot::Plugins

  def initialize(options = { :config => Servbot::Const::CONFIG_FILE })
    @commands = {}
    @verbose = options.has_key?(:verbose) ? options[:verbose] : false
    @options = options

    Servbot::Config.config = options[:config]
    trap("TERM") { EM.stop; exit(0) }
    trap("INT")  { EM.stop; exit(0) }

    load_config
    load_plugins
    start_loop
  end

  # Load the configuration file if it exists
  def load_config
    if File.exists?(@options[:config])
      Servbot::Config.from_file(@options[:config])
    elsif File.exists?(Servbot::Const::CONFIG_FILE)
      Servbot::Config.from_file(Servbot::Const::CONFIG_FILE)
    end
  end

  # Starts the main Eventmachine loop
  def start_loop
    EM.run do
      @irc = Servbot::IRC.connect(nil)
      @irc.add_observer(self)
    end
  end

  # Reset the command list
  def clear_commands
    @commands = {}
  end
  
  # Add a command and associated proc to the command list
  def add_command(command, proc)
    @commands[command] = proc
  end
  
  # Runs a command proc if it exists in the commands lookup table
  def run(command, args)
    proc = @commands[command]
    proc ? proc.call(args) : (puts "command #{command} not found. ")
  end

  # Subscriber for IRC events
  def update(time, username, command, args)
    run command, args
  end
end
