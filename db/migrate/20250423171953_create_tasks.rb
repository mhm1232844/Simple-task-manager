class CreateTasks < ActiveRecord::Migration[7.0] # Adjust version if needed
  def change
    create_table :tasks do |t|
      t.string :title, null: false # Add null: false constraint
      t.text :description
      t.date :due_date
      t.boolean :completed, default: false, null: false # Ensure default and non-null

      t.timestamps
    end
  end
end