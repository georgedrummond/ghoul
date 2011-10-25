# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "ghoul"
  s.version     = Ghoul::VERSION
  s.authors     = ["George Drummond"]
  s.email       = ["george@accountsapp.com"]
  s.homepage    = ""
  s.summary     = %q{Ghoul is ...}
  s.description = %q{Ghoul is ...}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "sinatra"
  s.add_dependency "haml"
  s.add_dependency "sass"
  s.add_dependency "grit"
  s.add_dependency "georgedrummond_sinatra_helpers"
  s.add_dependency "ghoul_grack", "0.0.1"
  s.add_dependency "coderay"
  s.add_dependency "rack-tunnel"
  s.add_dependency "redcarpet"
  
  s.post_install_message = <<-message
  
  
Thanks for installing ghoul, the super simple git manager.
  
  
  message
end
