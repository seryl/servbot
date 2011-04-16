class Servbot::Bot
  include Servbot::Plugins

  def initialize(options = { :config => Servbot::Const::CONFIG_FILE })
    @verbose = options.has_key?(:verbose) ? options[:verbose] : false
    @options = options
    trap("TERM") { EM.stop; exit(0) }
    trap("INT")  { EM.stop; exit(0) }

    load_config
    load_events
    load_plugins
    start_loop
  end

  # Load the configuration file if it exists
  def load_config
    Servbot::Config.config = @options[:config]

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
end
