require "rubygems"
require "rack"

module Ghoul
  module Server
    
    def self.start
        begin
          config_path = File.join(File.dirname(__FILE__), "..", "config.ru")
          
          message = <<-start_message.gsub(/^ {8}/, '')
          
          ###########################################################
          #
          #   Using Ghoul via the "ghoul server" command is
          #   insecure by default. It is only intended for a secure
          #   local environment e.g. behind a firewall where only you
          #   or people you trust can access your machine on a lan.
          #
          #############################################################
          
          Starting service on http://0.0.0.0:3003

          start_message
          
          puts message
          
          ENV['RACK_ENV'] = "production"
          Rack::Server.new(:config => config_path, :Port => 3003).start
          
          # Open the users browser to our new server
          # system("open http://0.0.0.0:3003")
        rescue
          puts "  --> The ghoul shut down."
        end

    end    
  end  
end
