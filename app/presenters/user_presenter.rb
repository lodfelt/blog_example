class UserPresenter < BasePresenter

  presents :user

  def avatar
    h.image_tag user.avatar_url(:thumb), class: "img-polaroid"
  end

  def links()
    links = user.profile.links.split(" ") unless  user.profile.links.blank?
    format_links(links)
  end

  def about
    user.profile.about
  end

  def name
    user.name
  end

  def email
    user.email
  end

  private

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
    h.raw html
  end

end