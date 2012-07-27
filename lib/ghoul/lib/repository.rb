module Ghoul
  module Repository
    def repos_path
      home = ENV['HOME']
      repos_path = File.join(home, "repos")
      return repos_path
    end
    
    def repos_path_exists?
      File.directory? repos_path
    end
        
    def repository(name)
      path = File.join(repos_path, name)
      return Grit::Repo.new(path, :is_bare => true)
    end
    
    def repositories
      directory_entries = Dir.entries(repos_path)
      return directory_entries.find_all { |r| File.directory?( File.join(repos_path, r) ) }
    end
    
    def commit_from_repository(repository, commit_id)
      if commit_id == "trunk"
        commit = repository(repository).commits.first or raise NoCommits
      else
        commit = repository(repository).commit(params[:commit])
      end
      return commit
    end
    
    def create_repository(name)
      name = name.rstrip.gsub(' ', '_')
      path = File.join(repos_path, name)
      if File.exist?(path)
       return  false
      end
      Grit::Repo.init_bare(path)
    end
    
  class NoCommits < NameError; end
  end
end
