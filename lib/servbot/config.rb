require 'mixlib/config'

module Servbot
  class Config
    extend(Mixlib::Config)

    server 'localhost'
    port '6667'
    channels ['servbot']

    username 'servbot'
    password nil
    nickname 'servbot'
  end
end
