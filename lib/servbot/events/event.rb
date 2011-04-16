module Servbot::Event
  extend self
  
  def handler
    @handler ||= nil
  end
end
