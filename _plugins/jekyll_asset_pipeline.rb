require "jekyll_asset_pipeline"

module JekyllAssetPipeline
  class CssTagTemplate < Template
    def self.filetype
      '.css'
    end

    def html
      "<link rel=stylesheet href=\"#{@path}/#{@filename}\" />"
    end
  end

  class JavaScriptTagTemplate < Template
    def self.filetype
      '.js'
    end

    def html
      "<script src=\"#{@path}/#{@filename}\"></script>"
    end
  end

  class CssCompressor < Compressor
    require 'yui/compressor'

    # Tweak Java runtime
    # source: https://github.com/sstephenson/ruby-yui-compressor/issues/19
    class YUI::Compressor
      def command
        @command.insert 1, "-Xss8m"
        @command.map { |word| Shellwords.escape(word) }.join(" ")
      end
    end

    def self.filetype
      '.css'
    end

    def compress
      return YUI::CssCompressor.new.compress(@content)
    end
  end

  class JavaScriptCompressor < Compressor
    require 'yui/compressor'

    def self.filetype
      '.js'
    end

    def compress
      return YUI::JavaScriptCompressor.new(munge: true).compress(@content)
    end
  end
end
