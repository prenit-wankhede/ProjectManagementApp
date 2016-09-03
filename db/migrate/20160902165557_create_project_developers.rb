class CreateProjectDevelopers < ActiveRecord::Migration
	def change
		create_table :project_developers do |t|
			t.integer :project_id
			t.integer :developer_id
			t.timestamps null: false
		end
	end
end
