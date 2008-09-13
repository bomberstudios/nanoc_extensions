# A nanoc command to validate HTML and CSS files in the output folder
# 
# Place in your_site/lib/commands/ and use with 'nanoc validate'
# 
# A command that validates the HTML and CSS files in the output folder.
# It uses the W3C online validator, so it needs network access.
# 
# It requires the `w3c_validators` gem. Install it with
# 
#     $ gem install w3c_validators
# 
# Use it with
# 
#     $ nanoc validate
# 
# By default, it tries to validate HTML as XHTML 1.0 Transitional and CSS
# as CSS 2.0. You can change the options with the -d (doctype), -c (charset)
# and -p (CSS profile) options. For more info on options, run
# 
#     $ nanoc help validate

require 'w3c_validators'
require 'nanoc/cli'

class ValidateCommand < Nanoc::CLI::Command

  def name
    'validate'
  end

  def aliases
    []
  end

  def short_desc
    'Validates HTML and CSS'
  end

  def long_desc
    'Validates the HTML and CSS files in the output folder using the w3c_validators gem'
  end

  def usage
    "nanoc validate [options]"
  end

  def option_definitions
    [
      # --doctype
      {
        :long => 'doctype', :short => 'd', :argument => :required,
        :desc => "set the DOCTYPE to use, from #{W3CValidators::DOCTYPES.keys.map { |k| k.to_s }.sort.join(', ')}"
      },
      # --charset
      {
        :long => 'charset', :short => 'c', :argument => :required,
        :desc => "set the CHARSET to use, from #{W3CValidators::CHARSETS.keys.map { |k| k.to_s }.sort.join(', ')}"
      },
      # --profile
      {
        :long => 'profile', :short => 'p', :argument => :required,
        :desc => "set the CSS Profile to use, from #{W3CValidators::CSS_PROFILES.keys.map { |k| k.to_s }.sort.join(', ')}"
      }
    ]
  end

  def run(options, arguments)

    @output = @base.site.config[:output_dir]

    @doctype = options[:doctype] || :xhtml10_transitional
    @charset = options[:charset] || :utf_8
    @profile = options[:profile] || :css2

    @doctype = W3CValidators::DOCTYPES[@doctype.to_sym]
    @charset = W3CValidators::CHARSETS[@charset.to_sym]
    @profile = W3CValidators::CSS_PROFILES[@profile.to_sym]

    # Colorize the output :)
    def colorize(text, color_code); "#{color_code}#{text}\e[0m"; end
    def red(text); colorize(text, "\e[31m"); end
    def green(text); colorize(text, "\e[32m"); end

    validate '.html'
    validate '.css'

  end

  def validate ext
    @validator = (ext == ".css" ? W3CValidators::CSSValidator.new(:csslevel => @profile) : W3CValidators::MarkupValidator.new(:doctype => @doctype, :charset => @charset) )
    Dir["#{@output}/**/*#{ext}"].each do |file|
      puts colorize("\tValidating\t#{file}","\e[0m")
      if ext == ".html"
        puts colorize("\tDOCTYPE:\t#{@doctype}","\e[0m")
        puts colorize("\tCHARSET:\t#{@charset}","\e[0m")
      else
        puts colorize("\tCSS_PROFILE:\t#{@profile}","\e[0m")
      end
      results = @validator.validate_file(file)
      if results.errors.length > 0
        results.errors.each do |err|
          puts "\t#{red(err)}"
        end
      else
        puts "\t#{green('Valid!')}"
      end
      puts "\n"
    end
  end
end