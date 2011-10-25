#require './lib/little_git.rb'
#require './lib/little_git/lib/grack.rb'
require File.join(File.dirname(__FILE__), "lib", "ghoul")
#require File.join(File.dirname(__FILE__), "lib", "ghoul", "lib", "grack")
require "ghoul_grack"

# use Rack::ShowExceptions

# As a default, we wil store our repositories at
#
#  ~/repos
#    => /User/georgedrummond/repos
project_root = File.join(Dir.home, "repos")

config = {
  :project_root => project_root,
  :git_path => '/usr/bin/git',
  :upload_pack => true,
  :receive_pack => true,
}
::MAIN_APP = self

map "/repo" do
  run GhoulGrack::GitHttp::App.new(config)
end


map "/" do
  run Ghoul::Application
end
