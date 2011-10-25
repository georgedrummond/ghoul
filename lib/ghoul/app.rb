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
      erb :new_repo
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
      @repository = params[:repository]
      @hide_breadcrumbs = true
      erb :repo_settings
    end
    
    post "/repository/:repository/delete" do
      require "FileUtils"
      FileUtils.rm_rf File.join(repos_path, params[:repository])
      redirect("/")
    end
        
    get "/repository/:repository/:commit/diff/?" do
      @hide_breadcrumbs = true
      erb :diff
    end
    
    get "/repository/:repository/commits/?" do
      @repository = params[:repository]
      @commits = repository(@repository).commits
      @commit = commit_from_repository @repository, "trunk"
      @newest_commit = commit_from_repository(@repository, "trunk")
      @hide_breadcrumbs = true
      erb :commits
    end
    
    get "/repository/:repository/commits/:commit/?" do
      @repository = params[:repository]
      @commit = repository(@repository).commit(params[:commit])
      erb :diffs
    end
    
    get "/repositories" do
      @repositories = repositories
      erb :repositories
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
        erb :tree
      else
        @blob = resource  
        @syntaxer = CodeRay.scan(@blob.data, :plain).div(:line_numbers => :table)
        erb :blob
      end
    end
    
    error 404 do
      erb :'404'
    end
    
    error do
      #erb :'error'
    end
    
    error  NoCommits do
      erb :no_commits
    end
  end
end