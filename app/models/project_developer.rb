class ProjectDeveloper < ActiveRecord::Base
	
	belongs_to :project, class_name: "Project", foreign_key: :project_id, inverse_of: :project_developer_models
	belongs_to :developer, class_name: "User", foreign_key: :developer_id, inverse_of: :project_developer_models

end
