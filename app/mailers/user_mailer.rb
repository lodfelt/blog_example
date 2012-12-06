class UserMailer < ActionMailer::Base
  default from: "no_reply@lodfelt.se"

  def comment_on_article(article)
    @article = article
    mail to: article.user.email, subject: 'Your article was commented on'
  end
end
