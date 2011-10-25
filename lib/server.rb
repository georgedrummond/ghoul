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
          #   WARNING!!
          #
          #   Using Ghoul via the "ghoul server" command is
          #   insecure by default. It is only intended for a secure
          #   local environment e.g. behind a firewall where only you
          #   or people you trust can access your machine on a lan.
          #
          #   We are working on getting Ghoul playing with Gitolite
          #   so as to secure git access over ssh.
          #
          #   If you understand the current limitations feel free to
          #   continue, otherwise come back another day.
          #
          #   Thanks, Ghoul
          #
          #############################################################
          
          Starting service on http://0.0.0.0:3003

          start_message
          
          puts message
          
          ENV['RACK_ENV'] = "production"
          Rack::Server.new(:config => config_path, :Port => 3003).start
          
          # Open the users browser to our new server
          system("open http://0.0.0.0:3003")
        rescue
          puts "  --> The ghoul shut down."
        end

    end    
  end  
end
