class CreateStudies < ActiveRecord::Migration[5.2]
  def change
    create_table :studies do |t|
      t.integer :count

      t.string :date

      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :studies, [:user_id, :date], unique: true
  end
end
