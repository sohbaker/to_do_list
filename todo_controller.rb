require 'sinatra'
require 'sinatra/reloader'
require '../Todo_list/index_page'
gem 'rack-test'

use_list = ManageDatabase.new

get '/' do
  if params["add_item"]
    redirect to("/add_item")
  elsif params["find"] && params["edit"]
    redirect to('/edit_item')
  elsif params["complete"]
    redirect to('/mark_complete')
  elsif params["display_all"]
    redirect to('/view_all')
  elsif params["display_active"]
    redirect to('/view_active')
  elsif params["display_complete"]
    redirect to('/view_complete')
  end

  display_list = ""
  message = ""

  erb :index, :locals => {:display_list => display_list, :message => message} #:result => result}
end

get '/add_item' do
   action = params["add_item"]
   use_list.add_item(action)
   message = "#{action} has been added to your list"

  erb :index, :locals => {:display_list => display_list, :message => message} #:result => result}
end

get '/edit_item' do
  if params["find"] && params["edit"]
    find_item = params["find"]
    change_to = params["edit"]
    use_list.edit_item(find_item, change_to)
    message = "changed to #{change_to}"
  end

  erb :index, :locals => {:display_list => display_list, :message => message} #:result => result}
end

get '/mark_complete' do
  if params["complete"]
    change_status = params["complete"]
    use_list.mark_complete(change_status)
    message = "#{change_status} has been marked as complete"
  end

  erb :index, :locals => {:display_list => display_list, :message => message} #:result => result}
end

get '/view_all' do
  if params["display_all"]
    display_list = use_list.view_full_list
    display_list
  end

  erb :index, :locals => {:display_list => display_list} #:result => result}
end

get '/view_active' do
  if params["display_active"]
    display_list = use_list.view_active_list
  end

  erb :index, :locals => {:display_list => display_list, :message => message} #:result => result}
end

get '/view_complete' do
  if params["display_complete"]
    display_list = use_list.view_completed_list
  end

  erb :index, :locals => {:display_list => display_list, :message => message} #:result => result}
end

get '/delete' do
  if params["delete"]
    delete_this = params["delete"]
    use_list.user_deletes(delete_this)
    message = "#{delete_this} has been deleted"
  end

  erb :index, :locals => {:display_list => display_list, :message => message} #:result => result}
end
