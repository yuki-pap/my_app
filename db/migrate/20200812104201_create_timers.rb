class CreateTimers < ActiveRecord::Migration[5.2]
  def change
    create_table :timers do |t|
      t.string :start_time
      t.integer :time_to_calculate
      t.string :color
      t.string :stop_time
      t.integer :stopped_time 
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
