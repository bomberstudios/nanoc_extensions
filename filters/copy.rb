# This is a dumb binary filter. It just copies the original asset
# to the output folder

class CopyFilter < Nanoc::BinaryFilter
  identifier :copy
  def run(file)
    File.open(file.path)
  end
end