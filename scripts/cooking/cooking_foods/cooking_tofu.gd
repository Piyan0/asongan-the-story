extends CookingFood
class_name FoodTofu

func _id() -> String:
  return 'tofu'

func _recipe() -> Array[CookingIngredient]:
  return [
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
  ]
