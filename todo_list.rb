require 'sinatra'
require 'sinatra/reloader'
require '../Todo_list/manage_todo'
require '../Todo_list/todo_item'
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

  erb :index, :locals => {:list_of_actions => LIST_OF_ACTIONS, :choose_view => choose_view, :display_list => display_list}
end
