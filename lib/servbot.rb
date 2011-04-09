require 'rubygems'

module Servbot
  def self.run
    bot = Servbot::Bot
    puts Servbot::Config.server
  end
end

require 'servbot/const'
require 'servbot/config'
require 'servbot/channel'
require 'servbot/bot'

