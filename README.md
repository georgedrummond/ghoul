# Ghoul - Prettier Git For Everyone :)

Ghoul is a simple yet good looking interface for your git repositories written in sinatra. It is currently only for demonstration purposes and use on your secure local machine as it does not enforce any authentication as of yet.InstallationGhoul can be run either using the ghoul gem or by downloading the git repository and running through the rackup command.


## Installing via rubygems

    gem install ghoul
    ghoul server

    
## Installing from the git repository
  
    git clone http://github.com/georgedrummond/ghoul
    cd ghoul
    bundle install
    rackup
 
    
## How it works

Ghoul uses the grit, written by the guys at github for parsing your repositories which are located in a folder named "repos" within your home folder e.g. /Users/georgedrummond/repos. For git push, ghoul uses grack. Grack has no authentication so ghoul should only be used on your local machine.


## License

Copyright (c) 2011 George Drummond, george@accountsapp.com

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.