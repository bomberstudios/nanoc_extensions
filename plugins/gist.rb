def gist gist_id
  "<style type=\"text/css\" media=\"screen\">.gist pre { padding: 1em; } .gist pre span { font: 12px Consolas, monospace; }</style>\n" +
  "<script src=\"http://gist.github.com/#{gist_id.to_s}.js\"></script>"
end