class Recipe
  attr_reader :name, :description, :rating, :prep_time

  def initialize(recipe_details)
    @name = recipe_details[:name]
    @description = recipe_details[:description]
    @rating = recipe_details[:rating]
    @prep_time = recipe_details[:prep_time]
    @done = recipe_details.key?(:done) ? recipe_details[:done] : false
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
