class RemoveMarkerIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :markers, column: :field
    add_index    :markers, :field
    add_index :graphs, :number
  
  end
end
