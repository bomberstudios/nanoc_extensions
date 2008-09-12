# nanoc extensions

This is a playground for [nanoc](http://nanoc.stoneship.org) plugins, filters and commands.

Feel free to make with them as you please.

## commands/

### validate.rb

A command that validates the HTML and CSS files in the output folder. It uses the W3C online validator, so it needs network access.

It requires the `w3c_validators` gem. Install it with

      $ gem install w3c_validators

Use it with

      $ nanoc validate

By default, it tries to validate HTML as XHTML 1.0 Transitional and CSS as CSS 2.0. You can change the options with the -d (doctype), -c (charset) and -p (CSS profile) options. For more info on options, run

      $ nanoc help validate


## plugins/

### gist.rb

A simple plugin to embed Gists on your content. To embed a gist, use:

    <%= gist 8961 %>

It will include a small style definition (font: 12px Consolas) to make Gists easier to read.

### path_for.rb

A nanoc plugin that returns the path of a page given its page_id (its "name").

In your ERB-enabled layout or content, use:

    <a href="<%= path_for :home %>">Home</a>

## filters/

### copy.rb

A dumb filter that copies a binary asset to the output folder. Coded as an example of how a binary filter works.

### sips_flatten.rb

Uses the 'sips' command line tool in Mac OS X to flatten Fireworks images. Output format can be defined in the asset's YAML file using the 'flatten_format' property:

      binary: true
      filters: ['sips_flatten']
      flatten_format: 'png'

where `flatten_format` can be `png` (the default), `jpeg`, `tiff`, `gif`, `jp2`, `pict`, `bmp`, `qtif`, `psd`, `sgi` or `tga`.

It supports multiple asset representations, so you can output multiple formats by having a YAML like:

      binary: true
      filters: ['sips_flatten']
      reps:
        default:
          flatten_format: 'png'
          custom_path: /assets/image.png
        jpg:
          flatten_format: 'jpeg'
          custom_path: /assets/image.jpg


### sips_thumbnail.rb

Uses the 'sips' command line tool in Mac OS X to build image thumbnails. Output format can be defined in the asset's YAML file using the 'thumbnail_format' property. Max width/height is set with the `thumbnail_size` property:

      binary: true
      filters: ['sips_thumbnail']
      thumbnail_format: 'png'
      thumbnail_size: 200

where `thumbnail_format` can be `png` (the default), `jpeg`, `tiff`, `gif`, `jp2`, `pict`, `bmp`, `qtif`, `psd`, `sgi` or `tga`.

It supports multiple asset representations, so you can output multiple thumbnails by having a YAML like:

      binary: true
      filters: ['sips_thumbnail']
      reps:
        big:
          thumbnail_size: 200
        medium:
          thumbnail_size: 120
        small:
          thumbnail_size: 64
