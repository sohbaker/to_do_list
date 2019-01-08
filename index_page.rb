require '../Todo_list/database'
require 'pg'

class ManageDatabase
  def initialize
    @connect = RunDatabase.new
  end

  def execute_query(query)
    RunDatabase.run(query).first
  end

  def add_item(description)
    execute_query("INSERT into items(description) VALUES ('#{description}');")
  end

  def update_item(description, id)
    execute_query("UPDATE items SET description = '#{description}' WHERE id = '#{id}';")
  end

  def mark_complete(id)
    execute_query("UPDATE items SET active = false WHERE id = '#{id}';")
  end

  def delete_item(id)
    execute_query("DELETE FROM items WHERE id = #{id};")
  end

  def find_by_id(id)
    execute_query("SELECT * FROM items WHERE id = #{id};")
  end

  def view_full_list
    RunDatabase.run("SELECT * from items;").values
  end

  def view_active_list
    RunDatabase.run("SELECT * from items WHERE active = true;").values
  end

  def view_completed_list
    RunDatabase.run("SELECT * FROM items WHERE active = false;").values
  end

  # def count_active
  #   RunDatabase.run("SELECT COUNT(*) FROM items GROUP BY id HAVING active = true;")
  # end

end
