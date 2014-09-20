class RemoveFields < ActiveRecord::Migration
  def change
    remove_column :submissions, :links, :string
    remove_column :links, :user_id, :integer
  end
end
