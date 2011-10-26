require File.join(File.dirname(__FILE__), '..', 'lib', 'ghoul', 'lib', 'helpers.rb')

include Ghoul::Helpers

describe Ghoul::Helpers do
  require "georgedrummond_sinatra_helpers"
  include GeorgeDrummond::Sinatra::Helpers
  
  def url(url)
    return url
  end
  
  describe "title" do
    it "should assign title" do
      title("Web page title")
      @title.should == "Web page title"
    end
  end
  
  describe "partial" do
    def erb(partial, *args)
      return "erb(:'#{partial}', #{args})"
    end
    
    it "should use erb template from partials directory" do
      partial(:repo_header, :title => "Ghoul Repository" ).should == "erb(:'partials/_repo_header', {:layout=>false, :locals=>{:title=>\"Ghoul Repository\"}})"
    end
  end
  
  describe "date format" do
    it "should return date in a nicer format" do
      date = Time.new(2008,6,21, 13,30,0, "+09:00")
      date_format(date).should ==  "21 Jun 2008 @ 13:30"
    end
  end
  
  describe "breadcrumbs from splat" do
    it "should return the correct breadcrumbs" do
      breadcrumbs_from_splat("repository_name", "commitxyz", "george/drummond").should == "<a href=\"/repository/repository_name/commitxyz/tree/george/drummond/george\">george</a>/<a href=\"/repository/repository_name/commitxyz/tree/george/drummond/george/drummond\">drummond</a>"
    end
  end
  
  describe "filesize formatter" do
    it "should return size in bytes" do
      human_file_size(0).should == "0 bytes"
      human_file_size(234).should == "234 bytes"
      human_file_size(1023).should == "1023 bytes"
    end
    
    it "should return size in KB" do
      human_file_size(2034).should == "1 KB"
      human_file_size(2534).should == "2 KB"
      human_file_size(88034).should == "85 KB"
    end
    
    it "should return size in MB" do
      human_file_size(4194304).should == "4 MB"
      human_file_size(10485760).should == "10 MB"
    end
  end
  
end