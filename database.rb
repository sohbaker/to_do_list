require 'pg'

class Database
  def self.run(query)
      begin
    db = PG.connect(
      dbname: 'postgres',
      host: 'localhost',
      user: 'postgres',
      password: 'dataadmin'
    )
      result = db.exec(query)
    ensure
      db.close
      end
    return result
  end
end
