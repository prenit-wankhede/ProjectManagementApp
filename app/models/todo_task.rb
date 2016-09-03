class TodoTask < ActiveRecord::Base

	belongs_to :task_creator, class_name: "User", foreign_key: :tast_creator_id, inverse_of: :created_todo_tasks
	
	belongs_to :project, class_name: "Project", foreign_key: :project_id, inverse_of: :todo_tasks
	
	has_many :task_developers, class_name: "User", through: :todo_task_developer_models, source: :developer
	has_many :todo_task_developer_models, class_name: "TodoTaskDeveloper", foreign_key: :todo_task_id, inverse_of: :todo_task, dependent: :destroy

end
