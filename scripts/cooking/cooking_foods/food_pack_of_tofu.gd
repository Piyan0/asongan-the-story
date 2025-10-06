extends CookingFood
class_name FoodPackOfTofu

func _id() -> int:
  return DB.Food.PACK_OF_TOFU

func _recipe() -> Array[CookingIngredient]:
  return [
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientChilly.new(),
    IngredientChilly.new(),
    IngredientChilly.new(),
  ]
