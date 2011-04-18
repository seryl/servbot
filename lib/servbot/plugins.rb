$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'

module Servbot::Plugins
  include Servbot::Events
  extend self

  def plugins
    @plugins ||= {}
  end

  # Load a single plugin
  def load_plugin(file)
    require file
    plugin = File.basename(file, ".rb").capitalize
    @plugins << Object.const_get(:Servbot).const_get(:Plugins)\
      .const_get(plugin).new
  end

  # Load a directory of plugins
  def load_directory(directory)
    if Dir.exists?(directory)
      Dir.glob("#{directory}/*.rb").sort.each { |file|
        load_plugin file
      }
    else
      # Log that the plugin directory couldn't be loaded.
    end
  end

  #
  # Loads all plugins from the local plugins directory
  # and includes those from the config plugins path
  #
  def load_plugins
    clear_events

    # Base Plugins
    load_directory "#{File.dirname(__FILE__)}/plugins"

    # External plugins
    load_directory "#{File.dirname(Servbot::Config.config)}/plugins"
  end

  # Register all events from a plugin
  def register_events(plugin)
    plugin
  end

  # Clear a particular plugin from the lookup table
  def clear_plugin(plugin)
    # TODO:  Unregister event handlers?
    @plugins.delete plugin
  end

  # Reset the plugin lookup table
  def clear_plugins
    @plugins.keys.each { |key| clear_plugin(key) }
  end
end

class Servbot::Plugin
  attr_reader :name, :author
  attr_accessor :events

  def initialize
    @name = nil
    @author = nil
    @events = {}
  end
end
