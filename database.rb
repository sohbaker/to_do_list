require 'pg'

class RunDatabase
  def initialize
    PG.connect(
      dbname: 'postgres',
      host: 'localhost'
    )
    # if db = true
    #   return "get started with to do list"
    # end
  end
end
