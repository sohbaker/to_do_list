require 'pg'

class Database
  def initialize
    conn = PG.connect(
      dbname: 'postgres',
      host: 'localhost'
    )
    results = conn.exec("SELECT * from todo_list")

    p results
    puts results.getvalue(0,0)
  end
end
