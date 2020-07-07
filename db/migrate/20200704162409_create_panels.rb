class CreatePanels < ActiveRecord::Migration[5.2]
  def change
    create_table :panels do |t|
      t.string :color
      t.boolean :switch
      t.integer :number
      t.references :study, foreign_key: true
      t.timestamps
      t.index :number,unique: true
    end
  end
end
