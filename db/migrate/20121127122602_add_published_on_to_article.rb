class AddPublishedOnToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :published_on, :date
  end
end
