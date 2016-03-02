# encoding: utf-8
# page_keywords tag for Jekyll
# Generate the page keywords that should be different on the homepage and the other pages

# Developer: Benjamin Danon <benjamin@sphax3d.org> http://sphax3d.org
# Licence  : WTFPL (http://sam.zoy.org/wtfpl/COPYING)
# Version  : 0.1 (February 2016)

# Usage:
#   Add the tag {% page_keywords %} in a file that will be converted
#   This plugin use site.keywords and page.keywords

module Jekyll
  class PageKeywordsTag < Liquid::Tag
    def render(context)
      context = context.environments.first
      page_keywords = context["site"]["keywords"]
      page_keywords = [ page_keywords, context["page"]["keywords"] ].join(", ") if context["page"]["keywords"]
      return page_keywords
    end
  end
end

Liquid::Template.register_tag('page_keywords', Jekyll::PageKeywordsTag)
