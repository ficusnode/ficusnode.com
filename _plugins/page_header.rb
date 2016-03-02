# encoding: utf-8
# page_header tag for Jekyll
# Generate the page header that should be different on the homepage and the other pages

# Developer: Benjamin Danon <benjamin@sphax3d.org> http://sphax3d.org
# Licence  : WTFPL (http://sam.zoy.org/wtfpl/COPYING)
# Version  : 0.1 (February 2016)

# Usage:
#   Add the tag {% page_header %} in a file that will be converted
#   This plugin use site.title, site.tagline, page.title and the following methods to render the header :
#   - PageHeaderTag::page_header_home
#   - PageHeaderTag::page_header_page
#   - PageHeaderTag::site_title_img
#   This following variables are available in methods : @context, @site_title, @site_tagline, @page_title

module Jekyll
  class PageHeaderTag < Liquid::Tag
    def render(context)
      @context = context
      context = context.environments.first
      @site_title = context["site"]["title"]
      @site_tagline = context["site"]["tagline"]
      @page_title = context["page"]["title"]
      return page_header_home if context["page"]["url"] == "/"
      return page_header_page
    end

    def page_header_home
      "<div class=\"site-title\">#{site_title_img}<h1>#{@site_title}</h1></div>\n" + \
      "<p class=\"tagline\">#{@site_tagline}</p>"
    end

    def page_header_page
      "<div class=\"site-title\">#{site_title_img}#{@site_title}</div>\n" + \
      "<h1 class=\"tagline\">#{@page_title}</h1>"
    end

    def site_title_img
      logo = "logo-ficusnode-64x64.png"
      Liquid::Template.parse("{% img #{logo} alt:'Logo de ficus node' width:'{{ assets[\"#{logo}\"].width }}' height:'{{ assets[\"#{logo}\"].height }}' %}").render(@context)
    end
  end
end

Liquid::Template.register_tag('page_header', Jekyll::PageHeaderTag)
