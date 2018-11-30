require '../Todo_list/database'
require 'pg'

class ManageDatabase
  def initialize
    @connect = RunDatabase.new
    @log_number = 0
  end

  def save_to_database(data_to_save)
    sql = data_to_save
    RunDatabase.run(sql).first
  end

  def connect_to_database
    RunDatabase.new
  end

  def add_item(item)
    @log_number = @log_number + 1
    data = "INSERT into todo_list VALUES ('#{@log_number.to_i}','#{item}','active');"
    save_to_database(data)
    return @log_number
  end

  def edit_item(item_to_edit, change_to)
    data = "UPDATE todo_list SET action = '#{change_to}' WHERE action = '#{item_to_edit}';"
    save_to_database(data)
  end

  def mark_complete(completed_action)
    data = "UPDATE todo_list SET status = 'complete' WHERE action = '#{completed_action}';"
    save_to_database(data)
  end

  def view_full_list
    sql = "SELECT * from todo_list;"
    display_list = RunDatabase.run(sql).values
    display_list
  end

  def view_active_list
    sql = "SELECT * from todo_list WHERE status = 'active';"
    display_list = RunDatabase.run(sql).values
    display_list
  end

  def view_completed_list
    sql = "SELECT * from todo_list WHERE status = 'complete';"
    display_list = RunDatabase.run(sql).values
    display_list
  end
end
