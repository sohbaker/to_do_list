require 'sinatra'
require 'sinatra/reloader'

 get '/' do
   todo = params["action_item"]
   list_of_actions = []

   list_of_actions << todo
   erb :index, :locals => {:todo => todo, :list_of_actions => list_of_actions}

 end
