require 'sinatra'
require 'sinatra/reloader'
require '../Todo_list/manage_database'
# require '../Todo_list/manage_todo'
# require '../Todo_list/add_todo_item'
# require 'pp'
gem 'rack-test'

LIST_OF_ACTIONS = []

get '/' do
  use_list = ManageDatabase.new

  if params["add_item"]
   action = params["add_item"]
   use_list.add_item(action)
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
    display_list = use_list.view_full_list
  end

  if params["display_active"] || params["display_complete"]
    if params["display_active"]
      display_list = use_list.view_active_list
    elsif params["display_complete"]
      display_list = use_list.view_completed_list
    end
    return display_list
  end

  erb :index, :locals => {:list_of_actions => LIST_OF_ACTIONS, :display_list => display_list}
end
#
# get '/' do
#   use_list = ManageToDo.new
#
#   if params["add_item"]
#    todo = params["add_item"]
#    use_list.add_item(todo)
#   end
#
#   if params["find"] && params["edit"]
#     find_item = params["find"]
#     change_to = params["edit"]
#     use_list.edit_item(find_item, change_to)
#   end
#
#   if params["complete"]
#     change_status = params["complete"]
#     use_list.mark_complete(change_status)
#   end
#
#   if params["display_all"]
#     choose_view = "all"
#     display_list = use_list.view_full_list(choose_view)
#     p display_list
#   end
#
#   if params["display_active"] || params["display_complete"]
#     if params["display_active"]
#       choose_view = "active"
#     elsif params["display_complete"]
#       choose_view = "complete"
#     end
#     display_list = use_list.view_filtered_list(choose_view)
#   end
#
#   erb :index, :locals => {:list_of_actions => LIST_OF_ACTIONS, :display_list => display_list}
# end
