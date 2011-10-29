module Ghoul
  module Helpers
    def human_file_size(filesize)
      if filesize <= 1023
        return "#{filesize} bytes"
      elsif filesize <= 1024*1024
        return "#{filesize/1024} KB"
      else
        return "#{filesize/1024/1024} MB"
      end
    end
    
    def title(title)
      @title = title
    end
    
    def breadcrumbs_from_splat(repository, commit, splat)
      crumbs = splat.split("/")
      html = []
      path = []
      crumbs.each do |crumb|
        path << crumb
        html << "#{link_to( crumb, tree_for_commit_path(repository, commit, path.join('/'), nil ) )}"
      end
      return html.join("/")
    end
    
    def partial(template, locals = {})
      template = ('partials/_' + template.to_s).to_sym
      erb(template, :layout => false, :locals => locals)      
    end
    
    def date_format(datetime)
      datetime.strftime("%d %b %Y @ %H:%M")
    end
        
    def clippy(text, bgcolor='#FFFFFF')
      html = <<-EOF
        <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
                width="110"
                height="14"
                id="clippy" >
        <param name="movie" value="#{url('/flash/clippy.swf')}"/>
        <param name="allowScriptAccess" value="always" />
        <param name="quality" value="high" />
        <param name="scale" value="noscale" />
        <param NAME="FlashVars" value="text=#{text}">
        <param name="bgcolor" value="#{bgcolor}">
        <embed src="/flash/clippy.swf"
               width="110"
               height="14"
               name="clippy"
               quality="high"
               allowScriptAccess="always"
               type="application/x-shockwave-flash"
               pluginspage="http://www.macromedia.com/go/getflashplayer"
               FlashVars="text=#{text}"
               bgcolor="#{bgcolor}"
        />
        </object>
      EOF
    end
  end  
end