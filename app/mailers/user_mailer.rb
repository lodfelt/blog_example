class UserMailer < ActionMailer::Base
  default from: "no_reply@lodfelt.se"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.comment_on_article.subject
  #
  def comment_on_article(article)
    @article = article

    mail to: article.user.email, subject: 'Your article was commented on'
  end
end
