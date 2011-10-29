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
      url "/repository/#{repository}/trunk/tree"
    end
    
    def repository_git_url(repository)
      return "http://#{@request.host_with_port}/repo/#{repository}"
    end
    
    def repository_settings_path(repository)
      url "/repository/#{repository}/settings"
    end
    
    def clone_url(repository)
      return "http://#{@request.host_with_port}/repo/#{repository}"
    end
    
    def commits_path(repository, page=1)
      url "/repository/#{repository}/commits/#{page}"
    end
    
    def commit_path(repository, commit)
      url "/repository/#{repository}/commits/#{commit}"
    end
        
    def blob_for_commit_path(repository, commit, splat="", name="")
      parts = [repository, commit, "tree", splat, name].find_all { |i| i != ""}
      url "/repository/#{parts.join("/")}"
    end
    alias_method :tree_for_commit_path, :blob_for_commit_path
    
    def raw_blob_for_commit_path(repository, commit, splat="", name="")
      parts = [repository, commit, "raw", splat, name].find_all { |i| i != ""}
      url "/repository/#{parts.join("/")}"
    end
    
    def diff_for_commit_path(repository, commit)
      url "/repository/#{repository}/#{commit}/diff"
    end
  end
end