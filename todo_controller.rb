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

  erb :index, :locals => {:items => items, :message => message} #:result => result}
end

# get '/items' do # retrieve a list of resources
#   logger.info params
# end
#
# get '/items/:id' do # retrieve a single record
#
# end

post '/items' do # create a new record via the post method
  database.add_item(params['description'])
  redirect to("/")

  # item = ManageDatabase.new params["description"]
  # if item.save
  #   status 201
  # else
  #   status 500
  # end
end

put '/items/:id' do # update an existing record

end

delete '/items' do # destroy a record using delete
  logger.info params
  database.delete_item(params["id"])
  redirect to("/")
end
