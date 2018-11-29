require 'pg'

class RunDatabase
  def initialize
    connect = ManageDatabase.new
    # begin
      db = PG.connect(
        dbname: 'postgres',
        host: 'localhost'
      )
      db.exec(connect.save)
    #   ensure
    #   db.close
    # end
    results = db.exec("SELECT * from todo_list")
    puts results.values
  end
end

class ManageDatabase
  def save
    "INSERT into todo_list VALUES ('test','test');"
  end
end
