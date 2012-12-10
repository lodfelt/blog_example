module ArticlesHelper

  def output_content_for(article, detailed_flag)

    if detailed_flag
      if article.body.present?
        return article.body.html_safe
      elsif article.markdown.present?
        return markdown article.markdown
      end
    else
      if article.body.present?
        return truncate(article.body, length: 200).html_safe
      elsif article.markdown.present?
        return truncate(article.markdown, length: 200).html_safe
      end
    end
  end
end
