module Ghoul  
  class Application < Sinatra::Base
    include GeorgeDrummond::Sinatra::Helpers
    include Ghoul::Helpers
    include Ghoul::Repository
    include Ghoul::UrlHelpers
      
    set :public_folder, File.join(File.dirname(__FILE__), 'public')
    set :views, File.join(File.dirname(__FILE__), 'views')
    
    disable :logging, :dump_errors, :raise_errors, :show_exceptions
    
    get "/css/app.css" do
      sass :app
    end
  
    get "/" do
      redirect "/repositories"
    end
    
    get '/new_repo' do
      render_guide :new_repo, "New repository"
    end
    
    post '/new_repo' do
      @name = params[:name]
      if create_repository(@name)
        redirect repository_path(params[:name])
      else
        "Not possible"
      end
    end
    
    before '/repository/:repository/:commit/*' do
      @repository = params[:repository]
      @newest_commit = commit_from_repository(@repository, "trunk")
      @commit = commit_from_repository(@repository, params[:commit])
    end
    
    get "/repository/:repository/settings" do
      @hide_breadcrumbs = true
      haml :repo_settings
    end
    
    post "/repository/:repository/delete" do
      require "FileUtils"
      FileUtils.rm_rf File.join(repos_path, @repository)
      redirect("/")
    end
        
    get "/repository/:repository/:commit/diff/?" do
      @hide_breadcrumbs = true
      haml :diff
    end
    
    get "/repository/:repository/commits/?" do
      @repository = params[:repository]
      @commits = repository(@repository).commits
      @commit = commit_from_repository @repository, "trunk"
      @newest_commit = commit_from_repository(@repository, "trunk")
      @hide_breadcrumbs = true
      haml :commits
    end
    
    get "/repository/:repository/commits/:commit/?" do
      @repository = params[:repository]
      @commit = repository(@repository).commit(params[:commit])
      haml :diffs
    end
    
    get "/repositories" do
      @repositories = repositories
      haml :repositories
    end
    
    get '/repository/:repository/:commit/raw/*' do
      resource = repository(@repository).tree(@commit.id)/params[:splat][0]
      halt 200, {'Content-Type' => 'text/plain'}, resource.data
    end
        
    get '/repository/:repository/:commit/tree/?*' do      
      if params[:splat][0] != ""
        resource = repository(@repository).tree(@commit.id)/params[:splat][0]
      else
        resource = repository(@repository).tree
      end
      
      if resource.is_a?(Grit::Tree) || params[:splat][0] == ""
        @resource = resource
        @splat = params[:splat]
        haml :tree
      else
        @blob = resource  
        @syntaxer = CodeRay.scan(@blob.data, :plain).div(:line_numbers => :table)
        haml :blob
      end
    end
    
    error 404 do
      render_guide :'404', "File not found"
    end
    
    error do
      render_guide :'error', "Ghoul encountered an error"
    end
    
    error  NoCommits do
      render_guide :no_commits, "#{@repository} setup"
    end
  end
end