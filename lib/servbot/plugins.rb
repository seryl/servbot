module Servbot::Plugins
  extend self

  attr_reader :plugins

  # Loads plugins based on their filename.
  #
  # Ex: awesome.rb would load Servbot::Plugin::Awesome
  def load_plugins
    @plugins = []
    clear_commands

    # Base Plugins
    load_directory "#{File.dirname(__FILE__)}/plugins"
    # External plugins
    load_directory "#{File.dirname(Servbot::Config.config)}/plugins"

    @plugins.each do |plugin|
      # TODO: Initialize Plugin
    end
  end

  def load_directory(directory)
    if Dir.exists?(directory)
      Dir.glob("#{directory}/*.rb").sort.each { |file|
        require file
        add_plugin file
      }
    end
  end

  def add_plugin(file)
    plugin = File.basename(file, ".rb").capitalize
    @plugins << Object.const_get(:Servbot).const_get(:Plugins)\
      .const_get(plugin).new
  end
end
