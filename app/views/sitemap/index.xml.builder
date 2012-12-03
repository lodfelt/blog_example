xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc "http://www.lodfelt.se"
    xml.priority 1.0
  end
  for a in @articles
    xml.url do
      xml.loc article_url(a)
      xml.changefreq("weekly")
      xml.priority("0.7")
      if a.updated_at.nil?
        xml.lastmod(a.created_at.strftime("%Y-%m-%d"))
      else
        xml.lastmod(a.updated_at.strftime("%Y-%m-%d"))
      end
    end
  end

  for u in @users
    xml.url do
      xml.loc user_url(u)
      xml.changefreq("weekly")
      xml.priority("0.7")
      if u.updated_at.nil?
        xml.lastmod(u.created_at.strftime("%Y-%m-%d"))
      else
        xml.lastmod(u.updated_at.strftime("%Y-%m-%d"))
      end
    end
  end

  for t in @tags
    xml.url do
      xml.loc tag_url(t)
      xml.changefreq("weekly")
      xml.priority("0.7")
      if t.updated_at.nil?
        xml.lastmod(t.created_at.strftime("%Y-%m-%d"))
      else
        xml.lastmod(t.updated_at.strftime("%Y-%m-%d"))
      end
    end
  end

end