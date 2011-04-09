module Servbot
  class Bot

    def initialize
      if File.exists?(Servbot::Const::CONFIG_FILE)
        Servbot::Config.from_file(Servbot::Const::CONFIG_FILE)
      end

      EM.run do
        Servbot::IRC.connect(nil)
      end
    end

  end
end
