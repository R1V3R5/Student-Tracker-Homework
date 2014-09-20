class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :links
      t.integer :user_id
      t.timestamps
    end
  end
end
