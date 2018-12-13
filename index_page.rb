require '../Todo_list/database'
require 'pg'

class ManageDatabase
  def initialize
    @connect = RunDatabase.new
  end

  def execute_query(query)
    RunDatabase.run(query).first
    # delete_completed
  end

  def add_item(description)
    execute_query("INSERT into items(description) VALUES ('#{description}');")
  end

  def edit_item(item_to_edit, change_to)
    execute_query("UPDATE items SET description = '#{change_to}' WHERE description = '#{item_to_edit}';")
  end

  def mark_complete(completed_action)
    execute_query("UPDATE items SET active = false WHERE description = '#{completed_action}';")
  end

  def view_full_list
    RunDatabase.run("SELECT * from items;").values
  end

  def view_active_list
    sql = "SELECT * from items WHERE active = true;"
    display_list = RunDatabase.run(sql).values
    display_list.each do |row|
                    row
                  end
  end

  def view_completed_list
    sql = "SELECT * FROM items WHERE active = false;"
    display_list = RunDatabase.run(sql).values
    display_list.each do |row|
                    row
                    end
  end

  def delete_item(id)
    execute_query("DELETE FROM items WHERE id = #{id};")
  end

  # def delete__all_completed
  #   sql = "DELETE FROM todo_list WHERE status = 'complete';"
  #   delete = RunDatabase.run(sql).values
  #   delete
  # end

  # def number_of_active_todos
  #   view_active_list.display_list
  # end

  def number_of_active_todos
    view_active_list.display_list
  end

end
