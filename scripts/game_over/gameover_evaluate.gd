extends Node
class_name GameoverEvaluate

enum GameOverType{
  NO_GAMEOVER= 1,
  OUT_OF_STOCK,
  OUT_OF_MONEY,
}
func is_ingredients_available(food_request: Array[CookingFood], inventory: Array[CookingIngredient], shop: Array[CookingIngredient]) -> bool:
    
  var is_inventory_enough= Cooking.is_ingredients_can_make_foods(
    inventory, food_request
  )
  
  var is_shop_has_stock= Cooking.is_ingredients_can_make_foods(
    shop, food_request
  )
  #print(is_inventory_enough)
  if is_inventory_enough:
    print('inventory has stock.')
    return true
  elif is_shop_has_stock:
    print('shop has stock.')
    return true
  else:
    print('no stock left.')
    return false
  

func inventory_has_one_of_foods(food_request: Array[CookingFood], owned_food: Array[CookingFood]) -> bool:
  var is_has_food= Cooking.has_one_of_foods(owned_food, food_request)
  if is_has_food:
    print('inventory has food.')
  else:
    print('inventory has no food.')
  
  return is_has_food
    
func is_money_enough(food_request: Array[CookingFood], coin: int) -> bool:
  var is_enough= GameState.is_coin_enough_to_buy_one_of_foods(
    coin, food_request
  )
  if is_enough:
    print('money is enough to buy ingredients.')
  else:
    print('no money.')
  
  return is_enough

func get_food_request() -> Array[CookingFood]:
  var arr: Array[CookingFood]
  var request= GameState.food_request
  for i in request:
    arr.push_back(DB.food_from_id(i))
  return arr
  
func is_game_over(
  inventory_ingredients: Array[CookingIngredient],
  shop_ingredients: Array[CookingIngredient],
  inventory_foods: Array[CookingFood],
  food_request: Array[CookingFood],
  coin: int) -> int:
  
  
  if inventory_has_one_of_foods(food_request, inventory_foods):
    return GameOverType.NO_GAMEOVER
  if is_ingredients_available(food_request, inventory_ingredients, shop_ingredients):
    if not Cooking.is_ingredients_can_make_foods(inventory_ingredients, food_request): # then get from shop.
      if not is_money_enough(food_request, coin):
        print('Game over -out of money.')
        return GameOverType.OUT_OF_MONEY
    return GameOverType.NO_GAMEOVER
  else:
    print('Game over -out of stock.')
    return GameOverType.OUT_OF_STOCK

  
  return -1

  
func test(_test: GameoverTest):
  var game_over_type= is_game_over(
    _test._inventory_ingredients(),
    _test._shop_ingredients(),
    _test._inventory_foods(),
    _test._food_request(),
    _test._coin()
  )
  #print('>>', game_over_type)
  if game_over_type != _test._expected_result():
    print_rich('[color=red]Test failed![/color] \n')
    printraw('Gameover type: '+GameOverType.find_key(game_over_type) +'\n')
    printraw('Ecpected type: '+GameOverType.find_key(_test._expected_result()) +'\n')
  else:
    print_rich('[color=green]Test is succed![/color]')
    
