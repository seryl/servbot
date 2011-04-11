module Servbot
  class Bot
    attr_accessor :cmd_list, :connected
    @cmd_list = {}

    def initialize
      if File.exists?(Servbot::Const::CONFIG_FILE)
        Servbot::Config.from_file(Servbot::Const::CONFIG_FILE)
      end

      trap("TERM") { EM.stop; exit(0) }
      trap("INT") { EM.stop; exit(0) }

      EM.run do
        Servbot::IRC.connect(nil)
      end
    end

    def self.run(command, args)
      puts "command: #{command}"
      puts "args: #{args}"
      proc = Bot.commands[command]
      proc ? proc.call(args) : (puts "command #{ command } not found. ")
    end

    def self.clear_commands
      @commands = {}
    end

  end
end
