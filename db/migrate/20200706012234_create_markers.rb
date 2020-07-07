class CreateMarkers < ActiveRecord::Migration[5.2]
  def change
    create_table :markers do |t|
      t.string :color
      t.references :user, foreign_key: true
      t.string :field

      t.timestamps
      t.index :color, unique: true
      t.index :field, unique: true
    end
  end
end
