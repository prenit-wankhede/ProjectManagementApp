class ProjectsController < ApplicationController

	before_action :check_if_project_manager, only: [:new, :create, :edit, :update]

	def index
		if(current_user.role == "Project Manager")
			@all_managing_projects = current_user.managing_projects.order(updated_at: :desc)
			@all_developers = User.where(role: "Developer")
			@all_created_todo_tasks = current_user.created_todo_tasks.order(updated_at: :desc)
			@all_new_tasks = @all_created_todo_tasks.where(task_status: "New")
			@all_in_progress_tasks = @all_created_todo_tasks.where(task_status: "In Progress")
			@all_done_tasks = @all_created_todo_tasks.where(task_status: "Done")
			@all_unassigned_tasks = @all_created_todo_tasks.map{|task| task if task.task_developers.blank?}.compact
			
		else
			@developing_projects = current_user.developing_projects.order(updated_at: :desc)
			@all_assigned_tasks = current_user.development_tasks.order(updated_at: :desc)
			@all_new_assigned_tasks = @all_assigned_tasks.where(task_status: "New")
			@all_in_progress_assigned_tasks = @all_assigned_tasks.where(task_status: "In Progress")
			@all_done_assigned_tasks = @all_assigned_tasks.where(task_status: "Done")
		end
	end
	
	def new
		@project = Project.new
	end

	def create
		@project = current_user.managing_projects.new(project_params)
		
		if(@project.save)
			flash[:notice] = "Project created successfully"
			redirect_to project_path(@project)
		else
			render :new
		end
	end

	def show
		@project = Project.find_by(id: params[:id])
		if(!@project.blank?)
			@project_manager = @project.project_manager
			@project_developers = @project.developers
			@project_todo_tasks = @project.todo_tasks
			@all_new_tasks = @project_todo_tasks.where(task_status: "New")
			@all_in_progress_tasks = @project_todo_tasks.where(task_status: "In Progress")
			@all_done_tasks = @project_todo_tasks.where(task_status: "Done")
			@all_unassigned_tasks = @project.todo_tasks.map{|task| task if task.task_developers.blank?}
			render :show
		else
			render "errors/record_not_found"
		end
	end

	def edit
		@project = Project.find_by(id: params[:id])
		if(!@project.blank?)
			render :edit
		else
			render "errors/record_not_found"
		end
	end	
	
	def update
		@project = current_user.managing_projects.find_by(id: params[:id])
		
		if(!@project.blank?)
			if(@project.update(project_params))
				flash[:notice] = "Project updated successfully"
				redirect_to project_path(@project)
			else
				render :edit
			end
		else
			render "errors/record_not_found"
		end
		
	end

	def destroy
		@project = current_user.managing_projects.find_by(id: params[:id])
		
		if(!@project.blank?)
			if(@project.destroy)
				flash[:notice] = "Project deleted successfully"
				redirect_to projects_path
			else
				flash[:notice] = "An error occured while deleting this project"
				redirect_to project_path(@project)
			end
		else
			render "errors/record_not_found"
		end
	end

	def add_developers_page
		@project = Project.find_by(id: params[:id])
		if(!@project.blank?)
			@old_project_developers = @project.developers
			@new_developers = User.where.not(role: "Project Manager", id: @old_project_developers.map(&:id))
		else
			render "errors/record_not_found"
		end
	end

	def add_developers
		developer_ids = params[:developer_ids]
		@project = Project.find_by(id: params[:id])
		if(!@project.blank?)
			developer_ids.each do |developer_id|
				developer = User.find_by(id: developer_id)
				if(!developer.blank?)
					@project.developers << developer
				else
					render "errors/record_not_found"
				end
			end
			flash[:notice] = "Developers added successfully"
			redirect_to project_path(@project)
		else
			render "errors/record_not_found"
		end
		
	end
	
	private
	def project_params
		params.require(:project).permit(:project_name, :project_description)
	end	
	
	private
	def check_if_project_manager
		if(current_user.role != "Project Manager")
			render "errors/unauthorized"
		end
	end
	
end
