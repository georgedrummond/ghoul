module Ghoul
  module UrlHelpers
    def guides_path
      return "/guides"
    end
    
    def guide_path(guide)
      return "/guides/#{guide}"
    end
    
    def repositories_path
      url "/repositories"
    end
    
    def repository_path(repository)
      url "/#{repository}/trunk/tree"
    end
    
    def repository_git_url(repository)
      return "http://#{@request.host_with_port}/repo/#{repository}"
    end
    
    def repository_settings_path(repository)
      url "/#{repository}/settings"
    end
    
    def clone_url(repository)
      return "http://0.0.0.0:9292/repo/#{repository}"
    end
    
    def commits_path(repository)
      url "/#{repository}/commits"
    end
    
    def commit_path(repository, commit)
      url "/#{repository}/commits/#{commit}"
    end
    
    def tree_for_commit_path(repository, commit)
      url "/#{repository}/#{commit}/tree"
    end
    
    def blob_for_commit_path(repository, commit, splat=nil, name=nil)
      url "/#{repository}/#{commit}/tree/#{splat}/#{name}"
    end
    alias_method :tree_for_commit_path, :blob_for_commit_path
    
    def raw_blob_for_commit_path(repository, commit, splat)
      url "/#{repository}/#{commit}/raw/#{splat}"
    end
    
    def diff_for_commit_path(repository, commit)
      url "/#{repository}/#{commit}/diff"
    end
  end
end