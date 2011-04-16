require 'observer'

class Servbot::EventHandler < Proc
  include Observable

  attr_accessor :state

  def initialize(*args)
    super
    @state = nil
  end

  def call(*args)
    pre_call *args
    changed # notify observers
    super
    notify_observers(*args)
    post_call *args
  end

  def pre_call=(proc);  @pre_call = proc; end
  def post_call=(proc); @post_call = proc; end
  
  def pre_call(*args)
    changed # notify observers
    @pre_call.call(*args)
    notify_observers(*args)
  end

  def post_call(*args)
    changed # notify observers
    @post_call.call(args)
    notify_observers(*args)
  end
end
