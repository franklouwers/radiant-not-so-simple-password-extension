class ProtectedPage < Page
  
  description %{
    A "Protected Page" page protects contents with HTTP Basic 
    Authentication. The user name, password, and realm are set up in
    the "config" page part of the special "PassPage" page.
  }

  def cache?
    false
  end

  def config
    string = render_part(:config)
    @config ||= string.blank? ? {} : YAML::load(string)
  end
  
  def user
    config['user'].to_s
  end
  
  def password
    config['password'].to_s
  end
  
  def realm
    config['realm'] || "Application"
  end
  
end
