user = User.create(email: 'teste@cookbook.com', password: '123456')
RecipeType.create(name: 'Sobremesa')
RecipeType.create(name: 'Entrada')
Cuisine.create(name: 'Portuguesa')
brazilian_cuisine = Cuisine.create(name: 'Brasileira')
italian_cuisine = Cuisine.create(name: 'Italiana')
recipe_type = RecipeType.create(name: 'Prato Principal')
Recipe.create(title: 'Feijoada', recipe_type: recipe_type,
              cuisine: brazilian_cuisine,
              difficulty: 'Médio', cook_time: 120,
              ingredients: 'Feijão e carnes.', user: user,
              cook_method: 'Misturar o feijão com as carnes.')

Recipe.create(title: 'Macarronada', recipe_type: recipe_type,
              cuisine: italian_cuisine,
              difficulty: 'Fácil', cook_time: 30,
              ingredients: 'Macarrão e molho de tomate', user: user,
              cook_method: 'Cozinhar o macarrão e misturar com o molho.')
