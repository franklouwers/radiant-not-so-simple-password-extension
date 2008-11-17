module SimplePassword
  module SiteControllerExt
    def self.included(base)
      base.class_eval {
        include InstanceMethods
        alias_method_chain :process_page, :simple_password
      }
    end
  
    module InstanceMethods
    
      protected
  
      def process_page_with_simple_password(page)
        if page.class == ProtectedPage
          if authenticate_with_http_basic { |username, password|
				authinfo = Hash.new
	 			# Load config for passwords from special page
				passpage = Page.find_by_class_name("PassPage")
				passpage.parts.find_by_name("config").content.each_line do |l|
					#strip leading/ending whitespace, newlines, ...
					l = l.strip
					loginpass = l.split(/:/,2)
					unless loginpass[1].blank? or loginpass[0].blank?
						authinfo[loginpass[0].strip] = loginpass[1].strip
					end
				end
				!authinfo[username].blank? && authinfo[username] == password 
			}
            page.process(request, response)
          else
            request_http_basic_authentication( page.realm )
          end
        else
          page.process(request, response)
        end
      end
    end
  end
end
