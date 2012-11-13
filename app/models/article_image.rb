class ArticleImage < ActiveRecord::Base
  attr_accessible :article_id, :image, :article_main
  belongs_to :article
  scope :main, -> { where(article_main: true) }
  scope :inline, -> { where(article_main: false) }
  mount_uploader :image, ArticleUploader

  def update_main_article
    self.article_main = true
    self.save
    ArticleImage.where(article_id: self.article.id).each do |image|
      image.article_main = false unless image == self
      image.save
    end
  end
end
