user = User.create!(name: 'Everton', city: 'Salvador',
                   email: 'everton@teste.com', password: '123456',
                   admin: true)
RecipeType.create(name: 'Café da manhã')
RecipeType.create(name: 'Especial')
Cuisine.create(name: 'Portuguesa')
brazilian_cuisine = Cuisine.create(name: 'Americana')
italian_cuisine = Cuisine.create(name: 'Japonesa')
recipe_type = RecipeType.create(name: 'Petiscos')
Recipe.create!(title: 'Feijoada', recipe_type: recipe_type,
              cuisine: brazilian_cuisine,
              difficulty: 'Médio', cook_time: 120,
              ingredients: 'Feijão e carnes.', user: user,
              cook_method: 'Misturar o feijão com as carnes.')

Recipe.create!(title: 'Macarronada', recipe_type: recipe_type,
              cuisine: italian_cuisine,
              difficulty: 'Fácil', cook_time: 30,
              ingredients: 'Macarrão e molho de tomate', user: user,
              cook_method: 'Cozinhar o macarrão e misturar com o molho.')
