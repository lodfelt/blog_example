class AddDescriptionToImage < ActiveRecord::Migration
  def change
    add_column :article_images, :description, :string
  end
end
