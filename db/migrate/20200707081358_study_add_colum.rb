class StudyAddColum < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :num_graph, :integer
  end
end
