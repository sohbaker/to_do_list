require 'sinatra'
require 'sinatra/reloader'
gem 'rack-test'

LIST_OF_ACTIONS = []

get '/' do
  use_list = ManageToDo.new

  if params["add_item"]
   todo = params["add_item"]
   use_list.add_item(todo)
  end

  if params["find"] && params["edit"]
    find_item = params["find"]
    change_to = params["edit"]
    use_list.edit_item(find_item, change_to)
  end

  if params["complete"]
    change_status = params["complete"]
    use_list.mark_complete(change_status)
  end

  if params["display_all"]
    choose_view = "all"
    display_list = use_list.view_full_list(choose_view)
  end

  if params["display_active"] || params["display_complete"]
    if params["display_active"]
      choose_view = "active"
    elsif params["display_complete"]
      choose_view = "complete"
    end
    display_list = use_list.view_filtered_list(choose_view)
  end

  erb :index, :locals => {:list_of_actions => LIST_OF_ACTIONS, :find_item => find_item, :change_status => change_status, :choose_view => choose_view, :display_list => display_list}
end

class ToDoItem
  def initialize(todo)
    @todo = todo
    @status = "active"
    @filter = "all"
  end

  def todo_list_entry
    {
      :action => @todo,
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
    found_item = LIST_OF_ACTIONS.find { |y| y[:action] == "#{find_item}"}

    if found_item == nil
      return " "
    else
      found_item[:action] = "#{change_to}"
    end
  end

  def mark_complete(change_status)
    complete_item = LIST_OF_ACTIONS.find { |y| y[:action] == "#{change_status}"}

    if complete_item == nil
      return " " # need to consider error message in erb
    else
      complete_item[:status] = 'complete'
    end
  end

  def view_full_list(choose_view)
    full_list = LIST_OF_ACTIONS.find_all do |y|
      y[:filter] == "#{choose_view}"
    end

    if full_list == nil
      return " " # (error message)
    else
      return full_list
    end
  end

  def view_filtered_list(choose_view)
    filtered_list = LIST_OF_ACTIONS.find_all { |y| y[:status] == "#{choose_view}"}

    if filtered_list == nil
      return " " # (error message)
    else
      return filtered_list
    end
  end
end
