class TodoTaskDeveloper < ActiveRecord::Base
	
	belongs_to :todo_task, class_name: "TodoTask", foreign_key: :todo_task_id, inverse_of: :todo_task_developer_models
	
	belongs_to :developer, class_name: "User", foreign_key: :developer_id, inverse_of: :todo_task_developer_models

end
