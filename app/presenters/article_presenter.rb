class ArticlePresenter < BasePresenter

  presents :article

  def image
    return nil if article.images.main.first.blank?
    h.image_tag article.images.main.first.image_url(:large)
  end

  def title
    article.title
  end

  def tags
    html = ""
    article.tags.each do |tag|
      html << h.link_to(tag.name, h.tag_path(tag))
      hthml << ',' unless tag == article.tags.last
    end
    html
  end

  def inline_images
    html=""
    html << "<ul class='unstyled horizontal-list article-images'>"
    article.images.inline.each do |image|
      html<< "<li><figure>"
      html << "<a href='#{image.image_url}' target='_blank'>#{h.image_tag image.image_url(:thumb).to_s}</a>"
      if image.description.present?
        html <<  "<figcaption>#{image.description}</figcaption>"
      end
      html << "</figure></li>"
    end
    html << "</ul>"

    html.html_safe
  end

  def published_on
    h.l article.published_on, format: :blog_short_day_month_year
  end

end