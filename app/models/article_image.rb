class ArticleImage < ActiveRecord::Base
  attr_accessible :article_id, :image, :article_main, :description
  belongs_to :article
  scope :main, -> { where(article_main: true) }
  scope :inline, -> { where(article_main: false) }
  mount_uploader :image, ArticleUploader
  after_save :update_main_article

  def update_main_article
    if article_main_changed? && self.article_main == true
      ArticleImage.where(article_id: self.article.id).each do |image|
        unless image == self
          image.article_main = false unless image == self
          image.save
        end
      end
    end
  end
end
