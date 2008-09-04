require 'nanoc/cli'
class ValidateCommand < Nanoc::CLI::Command

  def name
    'validate'
  end

  def aliases
    %w( va )
  end

  def short_desc
    'Validates HTML'
  end

  def long_desc
    'Validates the HTML files in the output folder using the W3C validator'
  end

  def usage
    "nanoc validate [options]"
  end

  def option_definitions
    [
      # --doctype
      {
        :long => 'doctype', :short => 'd', :argument => :required,
        :desc => 'set the DOCTYPE to use',
        :long_desc => 'set the DOCTYPE to use'
      }
    ]
  end

  def run(options, arguments)
    Dir["output/**/*.html"].each do |file|
      Nanoc::CLI::Logger.instance.log(:high, "\t\e[33m" + "Validating " + "\e[0m" + file.chomp)

      page = File.read(file)
      page.gsub!(/<\?(php|=).*?\?>|<%.*?%>/m, '')

      open('|curl -sF uploaded_file=@-\;type=text/html http://validator.w3.org/check', 'r+') do |io|
        io << page; io.close_write
        while line = io.gets
          if line =~ /Congratulations/
            is_valid = true
          end
          if line =~ /Line (\d+),? Column (\d+)/
            Nanoc::CLI::Logger.instance.log(:high, "\t\e[1m" + "\e[31m" + "Error in line #{$1}, column #{$2.to_i + 1}" + "\e[0m")
          end
        end
        if is_valid
          Nanoc::CLI::Logger.instance.log(:high, "\t\e[1m" + "\e[32m" + "Validated" + "\e[0m")
        else
          Nanoc::CLI::Logger.instance.log(:high, "\t\e[1m" + "\e[31m" + "Error!" + "\e[0m")
        end
      end
      
    end
    # puts "Validating HTML"
  end

end