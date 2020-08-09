class CreateTimeByFieldTodays < ActiveRecord::Migration[5.2]
  def change
    create_table :time_by_field_todays do |t|
      t.integer :count

      t.references :time_by_field, foreign_key: true
      t.timestamps
    end
  end
end
