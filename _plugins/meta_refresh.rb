# encoding: utf-8
# meta_refresh tag for Jekyll
# Generate the refresh meta for the 50x pages

# Developer: Benjamin Danon <benjamin@sphax3d.org> http://sphax3d.org
# Licence  : WTFPL (http://sam.zoy.org/wtfpl/COPYING)
# Version  : 0.1 (February 2016)

# Usage:
#   Add the tag {% meta_refresh %} in a file that will be converted

module Jekyll
  class MetaRefreshTag < Liquid::Tag
    def render(context)
      context = context.environments.first
      return "<meta http-equiv=\"refresh\" content=\"60\">" if context["page"]["url"] =~ /^\/50.{1}\.html$/
    end
  end
end

Liquid::Template.register_tag('meta_refresh', Jekyll::MetaRefreshTag)
