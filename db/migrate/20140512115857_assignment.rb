class Assignment < ActiveRecord::Migration
  def change
    remove_column :assignments, :due_date, :date
    add_column :assignments, :due_date, :string
  end
end
