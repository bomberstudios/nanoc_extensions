# Sips Flatten Filter
# 
# Uses the 'sips' command line tool in Mac OS X to flatten Fireworks images

module Nanoc::BinaryFilters

  class SipsFlattenFilter < Nanoc::BinaryFilter

    identifier :sips_flatten

    def run(file)
      # Get temporary file path
      tmp_file = Tempfile.new("sips_filter")

      flatten_format = @asset_rep.flatten_format || "png"

      %x(sips -s format #{flatten_format} #{file.path} --out "#{tmp_file.path}">&/dev/null)

      tmp_file
    end
  end

end