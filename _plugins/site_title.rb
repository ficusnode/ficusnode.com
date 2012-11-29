module Jekyll
  class SiteTitleTag < Liquid::Tag
    def render(context)
      return context["page"]["site-title"] || context["site"]["title"]
    end
  end
end

Liquid::Template.register_tag('site_title', Jekyll::SiteTitleTag)
