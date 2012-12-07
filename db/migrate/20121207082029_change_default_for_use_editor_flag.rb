class ChangeDefaultForUseEditorFlag < ActiveRecord::Migration
  def up
  	change_column_default(:articles, :use_editor, true)
  end

  def down
  	change_column_default(:articles, :use_editor, nil)
  end
end
