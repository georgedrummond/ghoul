require "sinatra"
require "haml"
require "sass"
require "georgedrummond_sinatra_helpers"
require "grit"
require "coderay"
require "redcarpet"
require "time"

$:.unshift File.dirname(__FILE__)

def require_all(path)
  glob = File.join(File.dirname(__FILE__), path, '*.rb')
  Dir[glob].each do |f|
    require f
  end
end

require "version"
require_all "ghoul/lib"
require "ghoul/app"

