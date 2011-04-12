class Servbot::Bot
  attr_accessor :connected, :commands

  def initialize
    @commands = {}
    if File.exists?(Servbot::Const::CONFIG_FILE)
      Servbot::Config.from_file(Servbot::Const::CONFIG_FILE)
    end
    
    trap("TERM") { EM.stop; exit(0) }
    trap("INT") { EM.stop; exit(0) }
    
    EM.run do
      load_plugins
      Servbot::IRC.connect(nil)
    end
  end
  
  def self.run(command, args)
    puts "command: #{command}"
    puts "args: #{args}"
    proc = @commands[command]
    proc ? proc.call(args) : (puts "command #{ command } not found. ")
  end
  
  def clear_commands
    @commands = {}
  end
  
  def add_command(command, proc)
    @commands[command] = proc
  end

  def load_plugins
    clear_commands

    plugin_dir = [Servbot::Config.config.split[0], 'plugins'].join('/')
    if Dir.exists?(plugin_dir)
      Dir.glob("#{plugin_dir}/*.rb").each do |file|
        puts file
      end
    else
      puts "WARN: Plugin directory doesn't exist."
    end
  end
  
end
