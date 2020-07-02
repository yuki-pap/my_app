class CreateMonths < ActiveRecord::Migration[5.2]
  def change
    create_table :months do |t|

      t.references :user, foreign_key: true

      t.string :month

      t.integer :time_count

      t.timestamps
    end
      add_index :months, [:user_id, :month], unique: true
  end
end
