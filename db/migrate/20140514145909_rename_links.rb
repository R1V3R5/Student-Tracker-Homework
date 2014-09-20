class RenameLinks < ActiveRecord::Migration
  def change
    rename_column :links, :links, :content
  end
end
