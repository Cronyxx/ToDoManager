class SubtasksController < ApplicationController
	before_action :set_task
	before_action :set_subtask, except: [:create]

	def create
		@subtask = @task.subtasks.create(subtask_params)
		redirect_to @task
	end

	def destroy
		if @subtask.destroy
			flash[:success] = "Subtask was deleted."
		else
			flash[:error] = "Subtask could not be deleted."
		end
		redirect_to @task
	end

	def complete
		@subtask.update_attribute(:completed_at, Time.now)
		redirect_to @task, notice: "Subtask complete"
	end

	private

	def set_task
		@task = Task.find(params[:task_id])
	end

	def set_subtask
		params[:task].permit(:description)
	end

	def subtask_params
		params[:subtask].permit(:description)
	end


end
