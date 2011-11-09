require File.join(File.dirname(__FILE__), '..', 'lib', 'ghoul', 'lib', 'url_helpers.rb')

include Ghoul::UrlHelpers

describe Ghoul::UrlHelpers do
  before(:each) do
    @repository = "ghoul"
    @request = mock('request')
  end
  
  def url(url)
    return url
  end
  
  def unsafe_characters
    %q{#%^`{}'"\\ }
  end
  
  it "should route guides_path" do
    guides_path.should == "/guides"
  end
  
  it "should route repository_path" do
    repository_path(@repository).should == "/repository/ghoul/trunk/tree"
  end
  
  it "should route repository path for a repository with invalid URI characters" do
    repository = "ghoul#{unsafe_characters}repo"
    repository_path(repository).should == "/repository/#{URI.escape repository}/trunk/tree"
  end
  
  it "should route repository_git_url" do
    @request.should_receive(:host_with_port).and_return("localhost:3000")
    repository_git_url(@repository).should == "http://localhost:3000/repo/ghoul"    
  end
  
  it "should route repository_git_url for a repository with invalid URI characters" do
    repository = "ghoul#{unsafe_characters}repo"
    @request.should_receive(:host_with_port).and_return("localhost:3000")
    repository_git_url(repository).should == "http://localhost:3000/repo/#{URI.escape repository}"
  end
  
  it "should route repository_settings_path" do
    repository_settings_path(@repository).should == "/repository/ghoul/settings"    
  end
  
  it "should route repository_settings_path for a repository with invalid URI characters" do
    repository = "ghoul#{unsafe_characters}repo"
    repository_settings_path(repository).should == "/repository/#{URI.escape repository}/settings"
  end
  
  it "should route clone_url" do
    @request.should_receive(:host_with_port).and_return("localhost:3000")
    clone_url(@repository).should == "http://localhost:3000/repo/ghoul"
  end
  
  it "should route clone_url for a repository with invalid URI characters" do
    repository = "ghoul#{unsafe_characters}repo"
    @request.should_receive(:host_with_port).and_return("localhost:3000")
    clone_url(repository).should == "http://localhost:3000/repo/#{URI.escape repository}"
  end
  
  it "should route commit_path" do
    commit_path(@repository, "xyz").should == "/repository/ghoul/commits/xyz"
  end
  
  it "should route commit_path for a repository with invalid URI characters" do
    repository = "ghoul#{unsafe_characters}repo"
    commit_path(repository, "xyz").should == "/repository/#{URI.escape repository}/commits/xyz"
  end
  
  it "should route blob_for_commit_path" do
    blob_for_commit_path(@repository, "xyz", "abc/def", "ruby.rb").should == "/repository/ghoul/xyz/tree/abc/def/ruby.rb"
  end
  
  it "should route blob_for_commit_path for parts with invalid URI characters" do
    repository = "ghoul#{unsafe_characters}repo"
    splat = "#{unsafe_characters}/#{unsafe_characters}"
    name = "#{unsafe_characters}.rb"
    blob_for_commit_path(repository, "xyz", splat, name).should == "/repository/#{URI.escape repository}/xyz/tree/#{URI.escape splat}/#{URI.escape name}"
  end
  
  it "should route blob_for_commit_path without a path" do
    blob_for_commit_path(@repository, "xyz", "", "ruby.rb").should == "/repository/ghoul/xyz/tree/ruby.rb"
  end
  
  it "should route blob_for_commit_path with a nil name" do
    blob_for_commit_path(@repository, "xyz", "", nil).should == "/repository/ghoul/xyz/tree/"
  end
  
  it "should route raw_blob_for_commit_path" do
    raw_blob_for_commit_path(@repository, "commitxyz", "xyz/e/fe/fe").should == "/repository/ghoul/commitxyz/raw/xyz/e/fe/fe"
  end
  
  it "should route raw_blob_for_commit_path for repository with invalid URI characters" do
    repository = "ghoul#{unsafe_characters}repo"
    splat = "#{unsafe_characters}/#{unsafe_characters}"
    name = "#{unsafe_characters}.rb"
    raw_blob_for_commit_path(repository, "commitxyz", splat, name).should == "/repository/#{URI.escape repository}/commitxyz/raw/#{URI.escape splat}/#{URI.escape name}"
  end

  it "should route diff_for_commit_path" do
    diff_for_commit_path(@repository, "commitxyz").should == "/repository/ghoul/commitxyz/diff"
  end
  
  it "should route diff_for_commit_path for repository with invalid URI characters" do
    repository = "ghoul#{unsafe_characters}repo"
    diff_for_commit_path(repository, "commitxyz").should == "/repository/#{URI.escape repository}/commitxyz/diff"
  end
end