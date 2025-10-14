extends CookingIngredient
class_name IngredientWater

func _id() -> int:
  return DB.Ingredient.WATER

func _is_can_place(_in_plate: Array[CookingIngredient]) -> bool:
  var utils= CookingUtils.new(_in_plate)
  
  return utils.ingredients_count(DB.Ingredient.WATER) == 0
