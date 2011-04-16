module Servbot::Plugins::IRC::Channel
  extend self

  attr_reader :name
  attr_accessor :users

  def initialize(name)
    @name = name
    @users = Array.new
  end
end
