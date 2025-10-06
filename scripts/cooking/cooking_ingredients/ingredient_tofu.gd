class_name IngredientTofu
extends CookingIngredient

func _id() -> int:
  return DB.Ingredient.TOFU
  
func _is_can_place(in_plate: Array[CookingIngredient]) -> bool:
  var utils: CookingUtils= CookingUtils.new(in_plate)
  var tofu_count= utils.ingredients_count(DB.Ingredient.TOFU)
  if tofu_count<=2:
    return true
  else:
    return utils.ingredients_count(DB.Ingredient.RICE_ROLL) < 1
