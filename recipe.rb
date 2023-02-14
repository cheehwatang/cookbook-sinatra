class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(attributes = {})
    @name = attributes[:name] || ""
    @description = attributes[:description] || ""
    @rating = attributes[:rating] || 0
    @prep_time = attributes[:prep_time] || "0 mins"
    @done = attributes[:done] || false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end

  def mark_as_undone!
    @done = false
  end
end
