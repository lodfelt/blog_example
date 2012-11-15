class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.text :about
      t.string :links
      t.integer :user_id

      t.timestamps
    end
  end
end
