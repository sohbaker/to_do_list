require 'pg'

class RunDatabase
  def self.run(sql)
      begin
    db = PG.connect(
      dbname: 'postgres',
      host: 'localhost',
      user: 'postgres',
      password: 'dataadmin'
    )
      result = db.exec(sql)
    ensure
      db.close
      end
    return result
    # if db = true
    #   return "get started with to do list"
    # end
  end

end
