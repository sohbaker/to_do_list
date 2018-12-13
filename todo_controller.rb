require 'sinatra'
require 'sinatra/reloader'
require '../Todo_list/index_page'
gem 'rack-test'
require 'logger'

set :logger, Logger.new(STDOUT)

use_list = ManageDatabase.new

get '/' do
  items = use_list.view_full_list
  message = ""

  erb :index, :locals => {:items => items, :message => message} #:result => result}
end

post '/items' do
  use_list.add_item(params['description'])
  redirect to("/")
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
  end

  erb :index, :locals => {:display_list => display_list, :message => ''} #:result => result}
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

delete '/todos/:id' do
  # /todos/1
  # params["id"]
  # => 1

  if params["delete"]
    delete_this = params["delete"]
    use_list.user_deletes(delete_this)
    message = "#{delete_this} has been deleted"
  end

  erb :index, :locals => {:display_list => display_list, :message => message} #:result => result}
end
