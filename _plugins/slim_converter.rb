# Slim template converter
# source: http://yobriefca.se/blog/2012/03/22/slim-generator-for-octopress/

module Jekyll
  require 'slim'
  class SlimConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /slim/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      begin
        Slim::Template.new { content }.render
      rescue StandardError => e
        puts "!!! SLIM Error: " + e.message
      end
    end
  end
end
