class AddToMarkersNumber < ActiveRecord::Migration[5.2]
  def change
    add_column :markers, :number, :integer
  end
end
