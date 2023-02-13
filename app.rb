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
                             description: params["recipe_name"],
                             rating: params["rating"].to_i,
                             prep_time: params["prep_time"] })
  cookbook.create(new_recipe)
  redirect "/"
end

post "/destroy" do
  cookbook.destroy(params["recipe_index"].to_i)
  redirect "/"
end