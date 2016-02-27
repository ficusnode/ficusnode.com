# Image optimization for Jekyll Assets
# source:
# - https://github.com/jekyll/jekyll-assets/issues/141
# - https://github.com/jekyll/jekyll-assets/issues/101#issuecomment-57102241

require "jekyll/assets"
require "image_optim"

module Jekyll
  module Assets
    module Addons
      module Processors
        class ImageOptim
          PROCESSING_FOR = %W(image/gif image/jpeg image/png image/svg+xml).freeze
          PROCESSOR = proc { |_, data|
            ::ImageOptim.new(pngout: false, svgo: false).optimize_image_data(data) || data
          }
        end
      end
    end
  end
end

Jekyll::Assets::Addons::Processors::ImageOptim::PROCESSING_FOR.each do |val|
  Sprockets.register_preprocessor val, Jekyll::Assets::Addons::Processors::ImageOptim, Jekyll::Assets::Addons::Processors::ImageOptim::PROCESSOR
end
