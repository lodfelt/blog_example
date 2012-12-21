module ArticlesHelper

  def output_content_for(article)
    if article.body.present?
      return truncate(article.body, length: 250).html_safe
    elsif article.markdown.present?
      return markdown truncate(article.markdown, length: 250)
    end
  end

  def output_detailed_content_for(article)
    if article.body.present?
      return article.body.html_safe
    elsif article.markdown.present?
      return markdown article.markdown
    end
  end
end
