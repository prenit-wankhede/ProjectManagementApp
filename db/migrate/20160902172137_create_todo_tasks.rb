class CreateTodoTasks < ActiveRecord::Migration
	def change
		create_table :todo_tasks do |t|
			t.string :task_name, default: ""
			t.string :task_description, default: ""
			t.string :task_status, default: "New"
			t.integer :project_id
			t.integer :task_creator_id
			t.timestamps null: false
		end
	end
end
