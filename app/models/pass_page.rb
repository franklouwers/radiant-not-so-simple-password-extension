class PassPage < Page
  
  description %{
	A "PassPage" page is a special kind of page, with should have
	only one part: "config". It should contain (in a YAML structure)
	all the usernames and passwords that are allowed. 
	
	Please note that to actually protect a page with these passwords
	you need to set it's pagetype to "Protected".
	
    foo: secret
	john: smith
	
    You will need to quote strings with ambiguous meaning in YAML including 
    (not limited) to: "!abc", "foo:bar", "null", "true", "false", "yes", 
    "no", "on", "off" (see http://yaml.org/spec/1.2/#id2588633 and 
     http://en.wikipedia.org/wiki/YAML#Pitfalls_and_implementation_defects)
  }

  def cache?
    false
  end
  
end
