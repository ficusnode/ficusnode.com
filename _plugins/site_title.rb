# encoding: utf-8
# site_title tag for Jekyll
# Generate the site title that should be different on the homepage and the other pages

# Developer: Benjamin Danon <benjamin@sphax3d.org> http://sphax3d.org
# Licence  : WTFPL (http://sam.zoy.org/wtfpl/COPYING)
# Version  : 0.2 (December 2012)

# Usage:
#   Add the tag {% site_title %} in a file that will be converted
#   This plugin use site.title, site.url, site.baseurl and the following methods to render the title :
#   - SiteTitleTag::site_title_home
#   - SiteTitleTag::site_title_page
#   This following variables are available in methods : @site_title_text, @site_url

module Jekyll
  class SiteTitleTag < Liquid::Tag
    def render(context)
      @context = context
      context = context.environments.first
      @site_title_text = context["site"]["title"]
      @site_url = [context["site"]["url"], context["site"]["baseurl"], "/"].join("")
      return site_title_home if context["page"]["url"] == "/"
      return site_title_page
    end

    def site_title_home
      "<div class=\"site-title\">#{site_title_img}<h1>#{@site_title_text}</h1></div>"
    end

    def site_title_page
      "<a href=\"#{@site_url}\" title=\"Retour à la page d’accueil\" class=\"site-title\">#{site_title_img}#{@site_title_text}</a>"
    end

    def site_title_img
      logo = "logo-ficusnode-64x64.png"
      Liquid::Template.parse("{% img #{logo} alt:'Logo de ficus node' width:'{{ assets[\"#{logo}\"].width }}' height:'{{ assets[\"#{logo}\"].height }}' %}").render(@context)
    end
  end
end

Liquid::Template.register_tag('site_title', Jekyll::SiteTitleTag)
