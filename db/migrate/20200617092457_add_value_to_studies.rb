class AddValueToStudies < ActiveRecord::Migration[5.2]
  def change
    add_column :studies, :value, :boolean, default: false, null: false
  end
end
