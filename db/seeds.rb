# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'open-uri'

Cocktail.destroy_all
Dose.destroy_all
# Ingredient.destroy_all


# url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

# j_hash = JSON.parse(open(url).read)
# j_hash['drinks'].each do |drink|
#   Ingredient.create!({
#     name: drink["strIngredient1"],
#   })
# end



url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'

json_hash = JSON.parse(open(url).read)

json_hash['drinks'].each do |drink|
  cocktail = Cocktail.create!({
    name: drink['strDrink'],
    photo: drink["strDrinkThumb"],
  })
  jh = JSON.parse(open("https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{drink["idDrink"]}").read)
  drink = jh["drinks"][0]
  i = 1
  while i <= 15
    ing_name = drink["strIngredient#{i}"]
    desc = drink["strMeasure#{i}"]
    break if ing_name == ""
    ingredient = Ingredient.find_by(name: ing_name)
    if ingredient
      Dose.create!({
        cocktail: cocktail,
        ingredient: ingredient,
        description: desc,
      })
    end
    i += 1
  end
end
