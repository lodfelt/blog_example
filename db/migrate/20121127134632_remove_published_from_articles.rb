class RemovePublishedFromArticles < ActiveRecord::Migration
  def up
    remove_column :articles, :published
  end

  def down
    add_column :articles, :published, :boolean
  end
end
