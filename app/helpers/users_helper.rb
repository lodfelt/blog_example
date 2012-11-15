module UsersHelper

  def format_links(links)
    return if links.blank?
    html = ""
    links.each do |link|
      link.strip!
      link = "http://#{link}" unless link =~ /^https?:\/\//
      text = link.gsub(/^https?:\/\//, '')
      if text == links.last
        html << "<li><a href='#{link}' target='_blank'>#{text}</a></li>"
      else
        html << "<li><a href='#{link}' target='_blank'>#{text}</a></li><li class='divider'> | </li>"
      end
    end
    raw html
  end
end
