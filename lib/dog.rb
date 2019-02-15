class Dog
  attr_accessor :name, :breed
  attr_reader :id
  
  def initialize(name:, breed:, id: nil)
    @name = name
    @breed = breed
    @id = id
  end
  
  def save
    if self.id
      self.update
    else
      DB[:conn].execute("INSERT INTO dogs (name, breed) VALUES (?, ?)", self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_inserted_rowid FROM dogs")
    end
    dog
  end
  
  def update
  end
  
  def self.create(row)
  end
  
  def self.new_from_db(row)
    dog = Dog.new(name: row[1], breed: row[2], id: row[0])
  end
  
  def self.find_by_id(id)
  end
  
  def self.find_by_name(name)
    dog_info = DB[:conn].execute("SELECT * FROM dogs WHERE name = ?", name)[0]
    dog = self.new_from_db(dog_info)
  #   sql = "SELECT * FROM songs WHERE name = ?"
  # result = DB[:conn].execute(sql, name)[0]
  # Song.new(result[1], result[2], result[0])
    dog
  end
  
  def self.find_or_create_by(name)
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY,
        name TEXT,
        breed TEXT
      )
    SQL
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    DB[:conn].execute("DROP TABLE dogs")
  end
  
end