require 'mixlib/config'

module Servbot
  class Config
    extend(Mixlib::Config)

    server 'localhost'
    channel 'servbot'

    username 'servbot'
    password nil
    nickname 'servbot'
  end
end
