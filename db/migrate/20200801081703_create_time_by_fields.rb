class CreateTimeByFields < ActiveRecord::Migration[5.2]
  def change
    create_table :time_by_fields do |t|
      t.string :color
      t.integer :count
      t.string :field
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :time_by_fields, :field
  end
end
