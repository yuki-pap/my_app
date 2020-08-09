class CreateGraphs < ActiveRecord::Migration[5.2]
  def change
    create_table :graphs do |t|
      t.string :color, default: "white"
      t.boolean :fill, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
