module Jekyll
  class BlogImagesTag < Liquid::Tag

    def render(context)
      result_tag = ""
      img_folder = context["page"]["id"].gsub('/', '-')
      img_folder[0] = ''
      img_folder = "img/#{img_folder}/thumb/*.jpg"
      imgs = Dir[img_folder].sort_by { |x| x.gsub(/[^\d]/, '').to_i }
      imgs.each do |img|
        case img
        when /-left.jpg$/
          result_tag << "<div class='col-lg-6 col-md-6 col-xs-6 img-col-left'><img class='img-responsive' src='/#{img}' /></div>"
        when /-right.jpg$/
          result_tag << "<div class='col-lg-6 col-md-6 col-xs-6 img-col-right'><img class='img-responsive' src='/#{img}' /></div>"
        else
          result_tag << "<img class='img-responsive' src='/#{img}' />"
        end
      end
      result_tag
    end
  end
end

Liquid::Template.register_tag('blog_images', Jekyll::BlogImagesTag)
