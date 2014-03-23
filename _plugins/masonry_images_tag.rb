require 'fastimage'

module Jekyll
  module Converters
    class MasonryImageTag < Liquid::Tag

      def img_number img
        img.match(/.*\/(\d+).*\.jpg$/)[1].to_i
      end

      def thumb_dir context
        id_path = context["page"]["id"].gsub('/', '-')
        id_path[0] = ''
        thumb_dir = "img/#{id_path}/thumb"
      end

      def img_tag img
        classes = ["item"]
        dimension = FastImage.size(img)
        classes << ((dimension[0] > dimension[1]) ? "landscape" : "portrait")
        img.scan(/[a-z]\d/) { |m|  classes << m }
        "<div class='#{classes.join(' ')}' style=\"background-image: url('/#{img}');\"></div>"
      end

      def render(context)
        result_tag = "<div class='js-masonry' data-masonry-options='{ \"isFitWidth\": true, \"columnWidth\":\".grid-sizer\", \"itemSelector\": \".item\" }'><div class='grid-sizer'></div>"
        Dir["#{thumb_dir context}/*.jpg"].sort_by { |img| img_number(img) }.each do |img|
          result_tag << img_tag(img)
        end
        result_tag << "</div>"
      end

    end
  end
end

Liquid::Template.register_tag('masonry_images', Jekyll::Converters::MasonryImageTag)
