require 'mixlib/config'

module Servbot
  class Config
    extend(Mixlib::Config)

    server 'irc.efnet.org'
    channel ''

    username 'servbot'
    password nil
    nickname 'servbot'
  end
end
