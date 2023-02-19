class Recipe
  attr_reader :id
  attr_accessor :name, :description, :rating, :prep_time

  def initialize(attributes = {})
    @id = attributes[:id] || 0
    @name = attributes[:name] || ""
    @description = attributes[:description] || ""
    @rating = attributes[:rating] || 0
    @prep_time = attributes[:prep_time] || "0 mins"
    @done = attributes[:done] == 1
  end

  def self.all
    query = <<-SQL
      SELECT * FROM recipes
    SQL
    DB.results_as_hash = true
    DB.execute(query).map { |attributes| new(attributes.transform_keys(&:to_sym)) }
  end

  def self.find(id)
    query = <<-SQL
      SELECT * FROM recipes
      WHERE id = ?
    SQL
    DB.results_as_hash = true
    attributes = DB.execute(query, id).first
    return nil if attributes.nil?

    new(attributes.transform_keys(&:to_sym))
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
    update
  end

  def mark_as_undone!
    @done = false
    update
  end

  def save
    post_in_db? ? update : insert
  end

  def destroy
    query = <<-SQL
      DELETE FROM recipes
      WHERE id = ?
    SQL
    DB.results_as_hash = true
    DB.execute(query, @id)
  end

  private

  def update
    query = <<-SQL
      UPDATE recipes
      SET name = ?, description = ?, rating = ?, prep_time = ?, done = ?
      WHERE id = ?
    SQL
    DB.execute(query, @name, @description, @rating, @prep_time, (done? ? 1 : 0), @id)
  end

  def insert
    query = <<-SQL
      INSERT INTO recipes (name, description, rating, prep_time, done)
      VALUES (?, ?, ?, ?, ?)
    SQL
    DB.execute(query, @name, @description, @rating, @prep_time, (done? ? 1 : 0))
    @id = DB.last_insert_row_id
  end

  def post_in_db?
    query = <<-SQL
      SELECT * FROM recipes
      WHERE id = ?
    SQL
    DB.results_as_hash = true
    !DB.execute(query, @id).empty?
  end
end
