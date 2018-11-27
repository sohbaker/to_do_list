require 'sinatra'
require 'sinatra/reloader'
gem 'rack-test'

LIST_OF_ACTIONS = []

get '/' do
  use_list = ManageToDo.new

  if params["action_item"]
   todo = params["action_item"]
   use_list.add_item(todo)
  end

  if params["find"]
    find_item = params["find"]
    change_to = params["edit"]
    use_list.edit_item(find_item, change_to)
  end

  if params["mark as complete"]
    change_status = params["mark as complete"]
    use_list.mark_complete(change_status)
  end

  erb :index, :locals => {:list_of_actions => LIST_OF_ACTIONS, :find_item => find_item, :change_status => change_status}
end

class ToDoItem
  def initialize(todo)
    @todo = todo
    @status = "active"
    @filter = "all"
  end

  def todo_list_entry
    {
      :item => @todo,
      :status => @status,
      :filter => @filter
    }
  end
end

class ManageToDo
  def add_item(todo)
    add_to_list = ToDoItem.new(todo)
    LIST_OF_ACTIONS << add_to_list.todo_list_entry
  end

  def edit_item(find_item, change_to)
    found_item = LIST_OF_ACTIONS.find { |y| y[:item] == "#{find_item}"}

    if found_item == nil
      return "Couldn\'t find that item in your to do list"
    else
      found_item[:item] = "#{change_to}"
    end
  end

  def mark_complete(change_status)
    complete_item = LIST_OF_ACTIONS.find { |y| y[:item] == "#{change_status}"}

    if complete_item == nil
      return "Couldn\'t find that item in your to do list"
    else
      complete_item[:status] = 'completed'
    end
  end
end
