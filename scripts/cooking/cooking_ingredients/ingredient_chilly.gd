extends CookingIngredient
class_name IngredientChilly

func _id() -> int:
  return DB.Ingredient.CHILLY
  

func _is_can_place(in_plate: Array[CookingIngredient]) -> bool:
  var utils := CookingUtils.new(in_plate)
  return utils.is_plate_contains_less_than_or_same(_id(), 1)
  
