class AddColumnStudies < ActiveRecord::Migration[5.2]
  def change
    add_column :studies, :content_today, :text
    add_column :studies, :content_plan, :text
  end
end
