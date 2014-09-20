class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :workflow_state
      t.integer :course_id
      t.timestamps
    end
  end
end
