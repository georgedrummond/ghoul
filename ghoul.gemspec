# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "ghoul"
  s.version     = Ghoul::VERSION
  s.authors     = ["George Drummond"]
  s.email       = ["george@accountsapp.com"]
  s.homepage    = ""
  s.summary     = %q{Ghoul is a simple yet good looking interface for your git repositories written in sinatra. It is currently only for demonstration purposes and use on your secure local machine as it does not enforce any authentication as of yet.}
  s.description = %q{Ghoul is a simple yet good looking interface for your git repositories written in sinatra. It is currently only for demonstration purposes and use on your secure local machine as it does not enforce any authentication as of yet.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rack", ">= 1.0.0"
  s.add_dependency "sinatra", "1.3.1"
  s.add_dependency "sass"
  s.add_dependency "grit"
  s.add_dependency "georgedrummond_sinatra_helpers"
  s.add_dependency "ghoul_grack", "0.0.1"
  s.add_dependency "coderay"
  s.add_dependency "redcarpet"
  s.add_dependency "haml"
  
  s.post_install_message = <<-message
  
#################################################
#
# Thanks for installing Ghoul and giving it a go!
#
# This is a proof of concept release and in the
# next few months I hope to add to Ghoul and
# make it more fully featured.
#
# I think the idea behind Ghoul is kind of cool
# and if you do too, why not contribute and
# check out our github page.
#
# => http://github.com/georgedrummond/ghoul
#
#################################################

To Start the Ghoul server run:

    ghoul server
  
  message
end
