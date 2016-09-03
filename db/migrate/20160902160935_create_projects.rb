class CreateProjects < ActiveRecord::Migration
	def change
		create_table :projects do |t|
			t.string :project_name, default: ""
			t.string :project_description, default: ""
			t.integer :project_manager_id
			t.timestamps null: false
		end
	end
end
