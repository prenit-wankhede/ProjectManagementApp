class TodoTasksController < ApplicationController

	def index
		
	end
	
	def new
		@project = Project.find_by(id: params[:project_id])
		if(!@project.blank?)
			@todo_task = @project.todo_tasks.new()
		else
			render "errors/record_not_found"
		end
	end
	
	def create
		@project = Project.find_by(id: params[:project_id])
		if(!@project.blank?)
			@todo_task = @project.todo_tasks.new(todo_task_params)
			@todo_task.task_creator_id = current_user.id
			if(@todo_task.save)
				flash[:notice] = "New todo task created successfully"
				redirect_to project_todo_task_path(@project, @todo_task)
			else
				render :new
			end
		else
			render "errors/record_not_found"
		end
	end
	
	def show
		@project = Project.find_by(id: params[:project_id])
		if(!@project.blank?)
			@todo_task = @project.todo_tasks.where(id: params[:id]).first
			@task_developers = @todo_task.task_developers
			@new_task_developers = User.where.not(role: "Project Manager", id: @task_developers.map(&:id))
		else
			render "errors/record_not_found"
		end
	end
	
	def edit
		@project = Project.find_by(id: params[:project_id])
		if(!@project.blank?)
			@todo_task = @project.todo_tasks.find_by(id: params[:id])
		else
			render "errors/record_not_found"
		end
	end
	
	def update
		@project = Project.find_by(id: params[:project_id])
		if(!@project.blank?)
			@todo_task = @project.todo_tasks.find_by(id: params[:id])
			if(!@todo_task.blank?)
				if(@todo_task.update(todo_task_params))
					flash[:notice] = "Todo task updated successfully"
					redirect_to project_todo_task_path(@project, @todo_task)
				else
					render :edit
				end
			else
				render "errors/record_not_found"
			end
		else
			render "errors/record_not_found"
		end
	end
	
	def destroy
		@project = Project.find_by(id: params[:project_id])
		if(!@project.blank?)
			@todo_task = @project.todo_tasks.find_by(id: params[:id])
			if(!@todo_task.blank?)
				if(@todo_task.destroy)
					flash[:notice] = "Todo task deleted successfully"
					redirect_to project_path(@project)
				else
					flash[:notice] = "An error occured while deleting this todo task"
					redirect_to project_todo_task_path(@project, @todo_task)
				end
			else
				render "errors/record_not_found"
			end
		else
			render "errors/record_not_found"
		end
	end
	
	def assign_developers_page
		@project = Project.find_by(id: params[:project_id])
		if(!@project.blank?)
			@todo_task = @project.todo_tasks.where(id: params[:id]).first
			if(!@todo_task.blank?)
				@old_assigned_developers = @todo_task.task_developers
				@new_developers = User.where.not(role: "Project Manager", id: @old_assigned_developers.map(&:id))
			else
				render "errors/record_not_found"
			end
			
		else
			render "errors/record_not_found"
		end
	end
	
	def assign_developers
		task_developer_ids = params[:task_developer_ids]
		@project = Project.find_by(id: params[:project_id])
		if(!@project.blank?)
			@todo_task = @project.todo_tasks.where(id: params[:id]).first
			if(!@todo_task.blank?)
				task_developer_ids.each do |developer_id|
					developer = User.find_by(id: developer_id)
					if(!developer.blank?)
						@todo_task.task_developers << developer
						if(!@project.developers.include?(developer))
							@project.developers << developer
						end
					else
						render "errors/record_not_found"
					end
				end
				flash[:notice] = "Developers assigned to task successfully"
				redirect_to project_path(@project)
			else
				render "errors/record_not_found"
			end
		else
			render "errors/record_not_found"
		end
		
	end
	
	def set_task_status
		task_status = params[:task_status]
		@project = Project.find_by(id: params[:project_id])
		if(!@project.blank?)
			@todo_task = @project.todo_tasks.where(id: params[:id]).first
			if(!@todo_task.blank?)
				if(@todo_task.task_status != task_status)
					@todo_task.update(task_status: task_status)
				end
				flash[:notice] = "Task status changed successfully"
				redirect_to project_path(@project)
			else
				render "errors/record_not_found"
			end
		else
			render "errors/record_not_found"
		end
		
	end
	
	def todo_task_params
		params.require(:todo_task).permit(:task_name, :task_description, :project_id)
	end

end
