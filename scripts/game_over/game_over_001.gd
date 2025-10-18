extends GameoverTest

func _expected_result() -> int:
  return GameoverEvaluate.GameOverType.OUT_OF_MONEY


func _shop_ingredients() -> Array[CookingIngredient]:
  return [
    IngredientChilly.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
  ]


func _inventory_ingredients() -> Array[CookingIngredient]:
  return [
    IngredientChilly.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
  ]

  

func _coin() -> int:
  return 4
  

func _food_request() -> Array[CookingFood]:
  return [
    FoodPackOfTofu.new()
  ]
  
  
func _inventory_foods() -> Array[CookingFood]:
  return []
  
