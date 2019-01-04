require 'sinatra'
require 'sinatra/reloader'
require '../Todo_list/index_page'
gem 'rack-test'
require 'logger'
use Rack::MethodOverride

set :logger, Logger.new(STDOUT)

database = ManageDatabase.new

get '/' do
  items = database.view_full_list
  message = ""
  active_count = database.count_active

  erb :index, :locals => {:items => items, :message => message, :active_count => active_count} #:result => result}
end

get '/items/:id/edit' do
  logger.info params
  item = database.find_by_id(params['id'])
  erb :edit_item, :locals => {:item => item}
end

get '/items/:status/active' do
  logger.info params
  items = database.view_active_list
  erb :view_active, :locals => {:item => items}
end

post '/items' do # create a new record via the post method
  database.add_item(params['description'])
  redirect to("/")
end

put '/items/:id/mark_complete' do # update an existing record
  database.mark_complete(params['id'])
  redirect to("/")
end

put '/items/:id' do
  database.update_item(params['description'], params['id'])
  redirect to("/")
end

delete '/items/:id' do # destroy a record using delete
  database.delete_item(params['id'])
  redirect to("/")
end
