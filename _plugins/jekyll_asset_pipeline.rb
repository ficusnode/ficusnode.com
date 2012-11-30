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
