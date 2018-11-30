require '../Todo_list/database'
require 'pg'

class ManageDatabase
  def initialize
    @connect = RunDatabase.new
  end

  def save_to_database(data_to_save)
    sql = data_to_save
    RunDatabase.run(sql).first
    # delete_completed
  end

  def add_item(item)
    # postgres id column will auto increment (look up how to do this)
    data = "INSERT into todo_list VALUES ('#{item}','active');"
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

  # def delete_completed
  #   sql = "DELETE FROM todo_list WHERE status = 'complete';"
  #   delete = RunDatabase.run(sql).values
  #   delete
  # end

  def view_full_list
    sql = "SELECT * from todo_list;"
    display_list = RunDatabase.run(sql).values
    return display_list.join(' ')
  end

  def view_active_list
    sql = "SELECT * from todo_list WHERE status = 'active';"
    display_list = RunDatabase.run(sql).values
    display_list

  end

  def view_completed_list
    sql = "SELECT * FROM todo_list WHERE status = 'complete';"
    display_list = RunDatabase.run(sql).values
    display_list
    # display_list.map do |row|
    #   { action: row[0],
    #     status: row[1]
    #   }
    # end
  end

end
