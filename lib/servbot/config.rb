begin
  require 'mixlib/config'
rescue LoadError
  require 'rubygems'
  require 'mixlib/config'
end

module Servbot::Config
  extend Mixlib::Config

  config Servbot::Const::CONFIG_FILE
  
  server 'localhost'
  port '6667'
  channels ['servbot']
  
  username 'servbot'
  password nil
  nickname 'servbot'
end
