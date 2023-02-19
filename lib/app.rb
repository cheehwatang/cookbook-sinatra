require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require 'sqlite3'
require_relative './recipe'
require_relative './scrape_allrecipes_service'

# set :bind, "0.0.0.0"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

dir = File.dirname(__FILE__)
DB = SQLite3::Database.new(File.join(dir, "db/recipes.db"))

get "/" do
  @recipes = Recipe.all
  erb :index
end

get "/new" do
  erb :new
end

get "/import/:ingredient" do
  @ingredient = params[:ingredient]
  @recipe_list = ScrapeAllrecipesService.call(@ingredient)
  erb :import
end

post "/import" do
  redirect "/import/#{params['ingredient']}"
end

post "/recipes" do
  new_recipe = Recipe.new({ name: params["recipe_name"],
                            description: params["recipe_description"],
                            rating: params["recipe_rating"].to_i,
                            prep_time: params["recipe_prep_time"] })
  new_recipe.save
  redirect "/"
end

post "/destroy" do
  Recipe.find(params["recipe_id"].to_i).destroy
  redirect "/"
end

post "/mark_as_done" do
  Recipe.find(params["recipe_id"].to_i).mark_as_done!
  redirect "/"
end

post "/mark_as_undone" do
  Recipe.find(params["recipe_id"].to_i).mark_as_undone!
  redirect "/"
end
