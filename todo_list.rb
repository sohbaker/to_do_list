require 'sinatra'
require 'sinatra/reloader'

LIST_OF_ACTIONS = []

get '/' do
  if params["action_item"]
   todo = params["action_item"]
   add_item(todo)
  end

  if params["find_and_edit"]
    edit = params["find_and_edit"]
    edit_item(edit)
  end

  erb :index, :locals => {:todo => todo, :list_of_actions => LIST_OF_ACTIONS, :edit => edit}
end

def add_item(todo)
  LIST_OF_ACTIONS << todo
end

def edit_item(edit)
  position_in_list = LIST_OF_ACTIONS.index("#{edit}")
  LIST_OF_ACTIONS.delete_at(position_in_list.to_i)
end
