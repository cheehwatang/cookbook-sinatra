require "nokogiri"
require "open-uri"

class ScrapeAllrecipesService
  def self.call(keyword)
    new(keyword).call
  end

  def initialize(keyword)
    @recipe_list = []
    url = "https://www.allrecipes.com/search?q=#{keyword}"
    @html_file = fetch_html(url)
  end

  def call
    search_for_recipes
    @recipe_list
  end

  private

  def search_for_recipes
    @html_file.search(".mntl-card-list-items").each do |element|
      break if @recipe_list.length >= 5

      recipe_url = element.attribute("href").value

      next unless valid_recipe_url?(recipe_url)

      recipe_html_doc = fetch_html(recipe_url)
      recipe_details = search_for_recipe_details(recipe_html_doc)

      @recipe_list << recipe_details
    end
  end

  def search_for_recipe_details(recipe_html_doc)
    recipe_details = {}

    recipe_details[:name] = recipe_html_doc.search(".article-heading")[0].text.strip
    recipe_details[:description] = recipe_html_doc.search(".article-subheading")[0].text.strip

    recipe_details[:rating] = 0
    recipe_html_doc.search(".mntl-recipe-review-bar__star-rating .icon-star").each { recipe_details[:rating] += 1 }

    recipe_html_doc.search(".mntl-recipe-details__item").each do |element|
      next unless element.search(".mntl-recipe-details__label")[0].text.strip == 'Prep Time:'

      recipe_details[:prep_time] = element.search(".mntl-recipe-details__value")[0].text.strip
    end

    recipe_details
  end

  USER_AGENT = "Mozilla/5.0 (Windows NT x.y; rv:10.0) Gecko/20100101 Firefox/10.0"

  def fetch_html(url)
    html_file = URI.open(url, "User-Agent" => USER_AGENT).read
    Nokogiri::HTML.parse(html_file)
  end

  def valid_recipe_url?(url)
    url.match(/^https:\/\/www\.allrecipes\.com\/recipe\/.+$/)
  end
end
