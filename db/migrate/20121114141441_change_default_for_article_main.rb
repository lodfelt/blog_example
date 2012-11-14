class ChangeDefaultForArticleMain < ActiveRecord::Migration
  def up
    change_column :article_images, :article_main, :boolean, default: false
  end

  def down
    change_column :article_images, :article_main, :boolean, default: nil
  end
end
