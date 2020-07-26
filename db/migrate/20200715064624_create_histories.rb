class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.text :image_data
      t.integer :number
      t.integer :percent
      t.references :user, foreign_key: true
      t.timestamps
      t.index :number, unique: true
    end
  end
end
