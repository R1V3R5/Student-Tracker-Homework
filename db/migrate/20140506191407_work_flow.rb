class WorkFlow < ActiveRecord::Migration
  def change
    remove_column :assignments, :workflow_state, :string
    add_column :assignments, :name, :string
    add_column :assignments, :description, :text
    add_column :submissions, :workflow_state, :string
  end
end
