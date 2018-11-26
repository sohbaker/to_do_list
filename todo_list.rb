require 'sinatra'
require 'sinatra/reloader'

LIST_OF_ACTIONS = []

get '/' do
  if params["action_item"]
   todo = params["action_item"]
   add_item(todo)
  end

  if params["find"]
    edit = params["find"]
    change_to = params["edit"]
    edit_item(edit, change_to)
  end

  erb :index, :locals => {:todo => todo, :list_of_actions => LIST_OF_ACTIONS, :edit => edit}
end

def add_item(todo)
  LIST_OF_ACTIONS << todo
end

def edit_item(edit, change_to)
  position_in_list = LIST_OF_ACTIONS.index("#{edit}")
  LIST_OF_ACTIONS.delete_at(position_in_list.to_i)
  LIST_OF_ACTIONS << change_to
end
