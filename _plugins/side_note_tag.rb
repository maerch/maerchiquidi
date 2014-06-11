module Jekyll
  class SiteNoteTag < Liquid::Tag

    def initialize(tag_name, site_note, tokens)
      super
      @site_note = site_note
    end

    def render(context)
      "<div class='site-note'><p>#{@site_note}</p></div>"
    end
  end
end

Liquid::Template.register_tag('site_note', Jekyll::SiteNoteTag)
