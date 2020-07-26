class RemoveStudyContentPlan < ActiveRecord::Migration[5.2]

    def up
    remove_column :studies, :content_plan
      end

   def down
     add_column :studies, :content_plan, :string
   end

end
