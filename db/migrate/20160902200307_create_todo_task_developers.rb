class CreateTodoTaskDevelopers < ActiveRecord::Migration
	def change
		create_table :todo_task_developers do |t|
			t.integer :todo_task_id
			t.integer :developer_id
			t.timestamps null: false
		end
	end
end
