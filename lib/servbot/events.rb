$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'servbot/utils'

Dir.glob("#{File.dirname(__FILE__)}/events/*.rb").sort.each { |file| require file }

module Servbot::Events
  extend self

  def events
    @events ||= {}
  end

  # Add an event and it's associated handler proc
  def add_event(event, proc)
    @events[event] = proc
  end

  # Clear a particular event
  def clear_event(event)
    @events.delete(event)
  end

  # Reset the event list
  def clear_events
    @events.keys.each { |event| clear_event(event) }
  end
end
