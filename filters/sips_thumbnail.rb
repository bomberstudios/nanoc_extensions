# Sips Filter
# 
# Uses the 'sips' command line tool in Mac OS X to resample images

module Nanoc::BinaryFilters

  class SipsThumbnailFilter < Nanoc::BinaryFilter

    identifier :sips_thumbnail

    def run(file)
      # Get temporary file path
      tmp_file = Tempfile.new("sips_filter")

      thumbnail_format = @asset_rep.thumbnail_format || "png"
      thumbnail_size = @asset_rep.thumbnail_size || 75

      %x(sips --resampleHeightWidthMax #{thumbnail_size.to_s} #{file.path} -s format #{thumbnail_format} --out "#{tmp_file.path}">&/dev/null)

      tmp_file
    end
  end

end