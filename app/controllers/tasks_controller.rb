class TasksController < ApplicationController
  before_action :require_user
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete]
  before_action :set_tasks, only: [:index]
	def index
    #setting @tasks to display on the index view
    @search_tag = params[:tag]
    if !@search_tag.blank?
      if Tag.exists?(:name => @search_tag)
        @tasks = Task.tagged_with(@search_tag).where(user_id: current_user.id, completed_at: nil).order(:dead_line).page(params[:page]).per(5)
      else
        @tasks = []
      end
    else
      @tasks = @tasks.order(:title).page(params[:page]).per(5)
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

  def edit
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

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Todo list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def complete
    @task.update_attribute(:completed_at, Time.now)
    flash.now[:success] = "Task completed, moved to archive."
    redirect_to root_path
  end

  def archive
    @tasks = current_user.tasks.where.not(completed_at: nil).order(completed_at: :desc).page(params[:page]).per(5)
  end 


	private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_tasks
    @tasks = current_user.tasks.where(completed_at: nil, user_id: current_user.id)
  end

	def task_params
    params.require(:task).permit(:title, :description, :dead_line, :tag_list, :tag, { tag_ids: [] }, :tag_ids, :user_id)
  end

end