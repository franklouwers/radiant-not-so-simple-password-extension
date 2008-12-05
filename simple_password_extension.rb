require_dependency 'application'
require_dependency 'site_controller_ext'

class SimplePasswordExtension < Radiant::Extension
  version "0.1"
  description %{
    A "Simple Password Page" page protects contents with HTTP Basic 
    Authentication. The user name, password, and realm are set up in
    a different page, with a special PassPage class.
    
    The PassPage should have only one part ("config"), which has the
    usernames and passwords in this pseudo YAML like format:
    
        john: secret
        mary: lamb
        foo: bar
    
    I've also added a "New User" button on that page. It asks you for
    a username, generates a random password and adds it to the page.
    
    SimplePasswordExtension depends on the authenticate_with_http_basic and
    request_http_basic_authentication methods, introduced with Rails 2, and
    Radiant > 0.6.5. It also requires the Shards extention, which is included
    in recent Radiant version.
    
    This is a modified version of the original Simple Password extension
    which can be found on 
    http://github.com/yoon/radiant-simple-password-extension.git
  }
  url "git://github.com/franklouwers/radiant-not-so-simple-password-extension.git"

  def activate
    SiteController.send :include, SimplePassword::SiteControllerExt
    raise "The Shards extension is required and must be loaded first!" unless defined?(admin.page)
    admin.page.edit.add :parts_bottom, 'spe_passgen', :before => 'edit_layout_and_type'
    PassPage
	ProtectedPage
  end
  
  def deactivate
  end
  
end
