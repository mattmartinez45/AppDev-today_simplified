class TasksController < ApplicationController
  def index
    matching_tasks = Task.all

    @list_of_tasks = matching_tasks.order({ :created_at => :desc })

    render({ :template => "tasks/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_tasks = Task.where({ :id => the_id })

    @the_task = matching_tasks.at(0)

    render({ :template => "tasks/show" })
  end

  def create
    the_task = Task.new
    the_task.user_id = params.fetch("query_user_id")
    the_task.name = params.fetch("query_name")
    the_task.category = params.fetch("query_category")
    the_task.due_date = params.fetch("query_due_date")
    the_task.time_estimate = params.fetch("query_time_estimate")

    if the_task.valid?
      the_task.save
      redirect_to("/tasks", { :notice => "Task created successfully." })
    else
      redirect_to("/tasks", { :alert => the_task.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_task = Task.where({ :id => the_id }).at(0)

    the_task.user_id = params.fetch("query_user_id")
    the_task.name = params.fetch("query_name")
    the_task.category = params.fetch("query_category")
    the_task.due_date = params.fetch("query_due_date")
    the_task.time_estimate = params.fetch("query_time_estimate")

    if the_task.valid?
      the_task.save
      redirect_to("/tasks/#{the_task.id}", { :notice => "Task updated successfully."} )
    else
      redirect_to("/tasks/#{the_task.id}", { :alert => the_task.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_task = Task.where({ :id => the_id }).at(0)

    the_task.destroy

    redirect_to("/tasks", { :notice => "Task deleted successfully."} )
  end
end
