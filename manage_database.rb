require '../Todo_list/database'
require 'pg'

class ManageDatabase
  def initialize
    @connect = RunDatabase.new
  end

  def save_to_database
    exec(@connect.save)
  end

  def add_item(item)
    "INSERT into todo_list VALUES ('#{item}','active');"
    save_to_database
  end

  def edit_item(item_to_edit, change_to)
    "UPDATE todo_list SET action = '#{change_to}' WHERE action = '#{item_to_edit}';"
    save_to_database
  end

  def mark_complete(completed_action)
    "UPDATE todo_list SET status = 'complete' WHERE action = '#{completed_action}';"
    save_to_database
  end

  def view_full_list
    display_list = @connect.exec("SELECT * from todo_list")
    return display_list.values
  end

  def view_active_list
    display_list = @connect.exec("SELECT * from todo_list WHERE status = 'active';")
    return display_list.values
  end

  def view_completed_list
    display_list = @connect.exec("SELECT * from todo_list WHERE status = 'complete';")
    return display_list.values
  end

  def exit
    db.close
  end
end
