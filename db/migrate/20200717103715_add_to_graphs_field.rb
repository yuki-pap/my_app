class AddToGraphsField < ActiveRecord::Migration[5.2]
  def change
    add_column :graphs, :field, :string
  end
end
