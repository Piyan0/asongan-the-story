extends CookingIngredient
class_name IngredientRiceRolls

func _id() -> String:
  return 'rice_rolls'

func _is_can_place(in_plate: Array[CookingIngredient]) -> bool:
  var utils: CookingUtils= CookingUtils.new()
  
  return utils.is_plate_contains_at_least('tofu', 3, in_plate)
