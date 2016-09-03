class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :omniauthable,
		 :recoverable, :rememberable, :trackable, :validatable
		 
	has_many :managing_projects, class_name: "Project", foreign_key: :project_manager_id, inverse_of: :project_manager, dependent: :destroy	 
	
	has_many :developing_projects, class_name: "Project", through: :project_developer_models, source: :project
	has_many :project_developer_models, class_name: "ProjectDeveloper", foreign_key: :developer_id, inverse_of: :developer, dependent: :destroy
	
	has_many :created_todo_tasks, class_name: "TodoTask", foreign_key: :task_creator_id, inverse_of: :task_creator, dependent: :destroy
	
	has_many :development_tasks, class_name: "TodoTask", through: :todo_task_developer_models, source: :todo_task
	has_many :todo_task_developer_models, class_name: "TodoTaskDeveloper", foreign_key: :developer_id, inverse_of: :developer, dependent: :destroy
end
