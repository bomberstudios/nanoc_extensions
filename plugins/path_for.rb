# A nanoc plugin that returns the path of a page given its page_id (its "name")
# 
# Installation:
# copy to your site's lib folder.
# 
# Usage:
# in your ERB-enabled layout or content, use: <a href="<%= path_for :home %>">Home</a>
# 

def path_for page_id
  @pages.select { |page| page.path.gsub("/","").gsub(".#{page.extension}","") == page_id.to_s }.first.path
end