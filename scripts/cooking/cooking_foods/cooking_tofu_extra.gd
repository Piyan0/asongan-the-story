extends CookingFood
class_name FoodTofuExtra

func _id() -> String:
  return 'tofu_extra'

func _recipe() -> Array[CookingIngredient]:
  return[
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientRiceRolls.new(),
  ]
