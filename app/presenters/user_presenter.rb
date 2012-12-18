class UserPresenter

  def initialize(user, template)
    @user = user
    @template = template
    @profile = @user.profile
    @user_links = @profile.links.split(" ") unless @profile.links.blank?
  end

  def avatar
    h.image_tag @user.avatar_url(:thumb), class: "img-polaroid"
  end

  def links()
    format_links(@user_links)
  end

  def about
    @profile.about
  end

  def name
    @user.name
  end

  def email
    @user.email
  end

  private

  # Any helper methods called in the presenter will need to be called through the template
  # like for example image_tag, link_to etc.
  def h
    @template
  end

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