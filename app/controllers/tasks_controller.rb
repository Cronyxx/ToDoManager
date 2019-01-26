class TasksController < ApplicationController
	before_action :require_user

	def index
    #setting @tasks to display on the index view
    @search_tag = params[:tag]
    if !@search_tag.blank?
      if Tag.exists?(:name => @search_tag)
        @tasks = Task.tagged_with(@search_tag).where(user_id: current_user.id).order(:title).page(params[:page]).per(5)
      else
        @tasks = []
      end
    else
      @tasks = current_user.tasks.order(:title).page(params[:page]).per(5)
    end
  end
 
  def show
    if Task.exists?(:id => params[:id])
      curr_task = Task.find(params[:id]) 
      if current_user.id == curr_task.user_id
  	    @task = curr_task
        return
      end
    end
    redirect_to root_path
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to @task
    else
      render :new
    end
	end

	private

	def task_params
    params.require(:task).permit(:title, :description, :tag_list, :tag, { tag_ids: [] }, :tag_ids, :user_id)
  end

end