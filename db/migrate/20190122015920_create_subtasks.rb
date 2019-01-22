class CreateSubtasks < ActiveRecord::Migration[5.2]
  def change
    create_table :subtasks do |t|
      t.string :description
      t.date :completed_at
      t.belongs_to :task, foreign_key: true
      
      t.timestamps
    end
  end
end
