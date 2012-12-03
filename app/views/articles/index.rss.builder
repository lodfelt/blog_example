xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "lodfelt.se blog"
    xml.description "A blog about nothing"
    xml.link articles_url

    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description article.body
        xml.pubDate article.published_on.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
      end
    end
  end
end