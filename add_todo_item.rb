require 'sinatra'

class AddToDoItem
  def initialize(todo)
    @todo = todo
    @status = "active"
    @filter = "all"
  end

  def todo_list_entry
    {
      :action => @todo,
      :status => @status,
      :filter => @filter
    }
  end
end
