class Servbot::Events::IRC < Servbot::Event
  # Runs an event proc if it exists in the events lookup table
  def run(event, args)
    proc = @events[event]
    proc ? proc.call(args) : (puts "event #{event} not found.")
  end

  # Subscriber for IRC events
  def update(time, username, command, args)
    run command, args
  end
end
