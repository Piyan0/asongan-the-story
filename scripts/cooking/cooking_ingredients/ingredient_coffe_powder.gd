extends CookingIngredient
class_name IngredientCoffePowder

func _id() -> int:
  return DB.Ingredient.COFFE_POWDER

func _is_can_place(_in_plate: Array[CookingIngredient]) -> bool:
  var utils= CookingUtils.new(_in_plate)
  
  return (
    utils.ingredients_count(DB.Ingredient.WATER) > 0 and
    utils.ingredients_count(DB.Ingredient.COFFE_POWDER) == 0
    )
