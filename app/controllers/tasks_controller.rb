class TasksController < ApplicationController
	def index
    	params[:tag] ? @tasks = Task.tagged_with(params[:tag]) : @tasks = Task.all
  	end
 
  	def show
    	@task = Task.find(params[:id])
  	end

  	def new
    	@task = Task.new
  	end

  	def create
    	@task = Task.new(task_params)
    	if @task.save
      		redirect_to @task
    	else
      		render :new
    	end
	end

	private

	def task_params
    	params.require(:task).permit(:title, :description, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
  	end
end