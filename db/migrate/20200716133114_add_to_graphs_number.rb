class AddToGraphsNumber < ActiveRecord::Migration[5.2]
  def change
    add_column :graphs, :number, :integer
  end
end
