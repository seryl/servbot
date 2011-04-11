module Servbot::Plugins

  def load_plugins
    Servbot::Bot.clear_commands
    
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
