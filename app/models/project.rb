class Project < ActiveRecord::Base

	belongs_to :project_manager, class_name: "User", foreign_key: :project_manager_id, inverse_of: :managing_projects
	
	has_many :developers, class_name: "User", through: :project_developer_models, source: :developer
	has_many :project_developer_models, class_name: "ProjectDeveloper", foreign_key: :project_id, inverse_of: :project, dependent: :destroy
	
	has_many :todo_tasks, class_name: "TodoTask", foreign_key: :project_id, inverse_of: :project, dependent: :destroy
	
end
