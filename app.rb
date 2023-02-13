require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

require_relative 'cookbook'
require_relative 'recipe'

set :bind, "0.0.0.0"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

csv_file_path = File.join(__dir__, 'recipes.csv')
cookbook = Cookbook.new(csv_file_path)

get "/" do
  @recipes = cookbook.all
  erb :index
end

get "/about" do
  erb :about
end

get "/new" do
  erb :new
end

post "/recipes" do
  new_recipe = Recipe.new({ name: params["recipe_name"],
                             description: params["recipe_description"],
                             rating: params["recipe_rating"].to_i,
                             prep_time: params["recipe_prep_time"] })
  cookbook.create(new_recipe)
  redirect "/"
end

post "/destroy" do
  cookbook.destroy(params["recipe_index"].to_i)
  redirect "/"
end

post "/mark_as_done" do
  recipe = cookbook.find(params["recipe_index"].to_i)
  recipe.mark_as_done!
  cookbook.update
  redirect "/"
end

post "/mark_as_undone" do
  recipe = cookbook.find(params["recipe_index"].to_i)
  recipe.mark_as_undone!
  cookbook.update
  redirect "/"
end