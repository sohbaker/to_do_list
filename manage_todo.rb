require 'sinatra'
require '../Todo_list/todo_item'

class ManageToDo
  def add_item(todo)
    add_to_list = ToDoItem.new(todo)
    LIST_OF_ACTIONS << add_to_list.todo_list_entry
  end

  def edit_item(find_item, change_to)
    found_item = LIST_OF_ACTIONS.find { |y| y[:action] == "#{find_item}"}

    if found_item == nil
      return " "
    else
      found_item[:action] = "#{change_to}"
    end
  end

  def mark_complete(change_status)
    complete_item = LIST_OF_ACTIONS.find { |y| y[:action] == "#{change_status}"}

    if complete_item == nil
      return " " # need to consider error message in erb
    else
      complete_item[:status] = 'complete'
    end
  end

  def view_full_list(choose_view)
    full_list = LIST_OF_ACTIONS.find_all do |y|
      y[:filter] == "#{choose_view}"
    end

    if full_list == nil
      return " " # (error message)
    else
      return full_list
    end
  end

  def view_filtered_list(choose_view)
    filtered_list = LIST_OF_ACTIONS.find_all { |y| y[:status] == "#{choose_view}"}

    if filtered_list == nil
      return " " # (error message)
    else
      return filtered_list
    end
  end
end
