# Cookbook Sinatra

Cookbook Sinatra is a simple web app prototype to search for recipes and store recipe information for future reference.

<br>

## Introduction

Cookbook Sinatra is created as part of a training project to learn the MVC software architectural pattern.

The aim of this project is to improve the understanding of MVC by implementing the Model, View, Controller, Repository (with .csv file) and Router role from separate Ruby file to Sinatra and SQLite3.

In Sinatra:

1. Model - Handled by the Reciple class (recipe.rb) 
2. View - Handled in the embedded ruby file (.erb) which displays using HTML and CSS.
3. Controller - Handled in app.rb.
4. Repository - Initialized in app.rb, but used in the Recipe class only.
5. Router - Handled in app.rb.

<br>

## Display

- Home Page
![Home Page]("https://github.com/cheehwatang/cookbook-sinatra/blob/main/images/home_page.png")

<br>

- Mobile Display
![Mobile Display]("https://github.com/cheehwatang/cookbook-sinatra/blob/main/images/mobile_display.png")

<br>

## Scope of Functionality

- Mark Recipe as Done and Delete Recipe Card
![Recipe Card]("https://github.com/cheehwatang/cookbook-sinatra/blob/main/images/recipe_cards.png")

<br>

- Manually Add New Recipe
![New Recipe Form]("https://github.com/cheehwatang/cookbook-sinatra/blob/main/images/new_recipe_form.png")

<br>

- Import Recipe from External Source
![Recipe Import]("https://github.com/cheehwatang/cookbook-sinatra/blob/main/images/recipe_imports.png")

<br>

## Technologies

1. [Ruby 3.1.2](https://www.ruby-lang.org/en/news/2022/04/12/ruby-3-1-2-released/)

2. [Sinatra 3.0.5](https://github.com/sinatra/sinatra)

3. [SQLite 3.37.2](https://www.sqlite.org/index.html)

<br>

## Installation

To test out the prototype, please make sure Ruby is installed in your machine.
Check out [Ruby](https://www.ruby-lang.org/en/documentation/installation/#rubyinstaller) for further information.

Once Ruby is installed, download the repository.

In your terminal, navigate to the downloaded folder and run the following command to fetch the gems specified in the ```Gemfile```.

```bash
bundle install
```

<br>

## Usage

Simply run the program from your terminal:

```bash
ruby app.rb
```

You should get this output:
```bash
== Sinatra (v3.0.4) has taken the stage on 4567 for development with backup from Thin
2023-02-17 23:29:02 +0800 Thin web server (v1.8.1 codename Infinite Smoothie)
2023-02-17 23:29:02 +0800 Maximum connections set to 1024
2023-02-17 23:29:02 +0800 Listening on localhost:4567, CTRL+C to stop
```

To see the web app, simply open your browser and go to ```localhost:4567```.

<br>

## License

[MIT](https://github.com/cheehwatang/cookbook-sinatra/blob/master/LICENSE.md)
