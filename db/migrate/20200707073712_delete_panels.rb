class DeletePanels < ActiveRecord::Migration[5.2]
  def change
    drop_table :panels
  end
end
