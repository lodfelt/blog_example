class AddMarkdownToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :markdown, :text
    add_column :articles, :use_editor, :boolean
  end
end
