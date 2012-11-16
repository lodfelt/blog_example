class RemoveImageFromArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :image
  end

  def down
    add_column :articles, :image, :string
  end
end
