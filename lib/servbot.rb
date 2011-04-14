module Servbot
  def self.run
    bot = Servbot::Bot
  end
end

require 'servbot/const'
require 'servbot/config'
require 'servbot/channel'
require 'servbot/irc'
require 'servbot/plugins'
require 'servbot/bot'
