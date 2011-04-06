require 'rubygems'

module Servbot
  def self.run
    bot = Servbot::Bot
    puts Servbot::Config.server
  end
end

require 'rockbot/config'
require 'rockbot/channel'
require 'rockbot/bot'

