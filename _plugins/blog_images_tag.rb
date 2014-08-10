module Jekyll
  module Converters
    class BlogImagesTag < Liquid::Tag

      def img_number img
        img.match(/.*\/(\d+).*/)[1].to_i
      end

      def thumb_dir context
        id_path = context["page"]["id"].gsub('/', '-')
        id_path[0] = ''
        thumb_dir = "img/#{id_path}/thumb"
      end

      def img_tag img
        case img
        when /-left.jpg$/
          "<div class='col-lg-6 col-md-6 col-xs-6 img-col-left'><img class='img-responsive' src='/#{img}' /></div>"
        when /-right.jpg$/
          "<div class='col-lg-6 col-md-6 col-xs-6 img-col-right'><img class='img-responsive' src='/#{img}' /></div>"
        else
          "<img class='img-responsive' src='/#{img}' />"
        end
      end

      def img_description_tag img, context
        description_file = "#{thumb_dir context}/#{img.split('/')[-1].split('.')[0]}.md"
        if File.exist? description_file
          markdown_converter = context.registers[:site].converters.find { |c| c.matches(".md") }
          "<div class='img-description'>#{markdown_converter.convert(IO.read(description_file))}</div>"
        else
          ""
        end
      end


      def render(context)
        result_tag = ""
        Dir["#{thumb_dir context}/*.{jpg,gif}"].sort_by { |img| img_number(img) }.each do |img|
          result_tag << img_tag(img)+ img_description_tag(img, context)
        end
        result_tag
      end

    end
  end
end

Liquid::Template.register_tag('blog_images', Jekyll::Converters::BlogImagesTag)
