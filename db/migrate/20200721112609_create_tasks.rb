class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :content
      t.boolean :complete, default: false
      t.references :study, foreign_key: true
      t.timestamps
    end
  end
end
