require '../Todo_list/database'
require 'pg'

class DatabaseAdapter
  def initialize
    @connect = Database.new
  end

  def add_item(description)
    Database.run("INSERT into items(description) VALUES ('#{description}');")
  end

  def update_item(description, id)
    Database.run("UPDATE items SET description = '#{description}' WHERE id = '#{id}';")
  end

  def mark_complete(id)
    Database.run("UPDATE items SET active = false WHERE id = '#{id}';")
  end

  def delete_item(id)
    Database.run("DELETE FROM items WHERE id = #{id};")
  end

  def find_by_id(id)
    Database.run("SELECT * FROM items WHERE id = #{id};").first
  end

  def view_full_list
    Database.run("SELECT * from items;").values
  end

  def view_active_list
    Database.run("SELECT * from items WHERE active = true;").values
  end

  def view_completed_list
    Database.run("SELECT * FROM items WHERE active = false;").values
  end

  def count_active
    Database.run("SELECT COUNT(*) FROM items WHERE active = true;").first
  end
end
