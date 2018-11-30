require 'sinatra'
require 'sinatra/reloader'
require '../Todo_list/manage_database'
gem 'rack-test'

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

  erb :index, :locals => {:display_list => display_list}
end
