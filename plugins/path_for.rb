# A nanoc plugin that returns the path of a page given its page_id (its "name")
# 
# Installation:
# copy to your site's lib folder.
# 
# Usage:
# in your ERB-enabled layout or content, use: <a href="<%= path_for :home %>">Home</a>
# 
# You can use a symbol or a string for your page name. Strings are nice for pages in subfolders:
# 
# <a href="<%= path_for "blog/2008/post_name" %>">A nice post</a>

def path_for page_id
  # Find page
  target_page = @pages.select { |page| page.path.gsub(/^\//,"").gsub(/\/$/,"").gsub(".#{page.extension}","") == page_id.to_s }.first
  if target_page.nil?
    return "#"
  else
    return target_page.path
  end
end