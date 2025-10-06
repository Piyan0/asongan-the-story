class_name CookingFood

func _id() -> int:
  return -1

func _recipe() -> Array[CookingIngredient]:
  return []
  
func is_done(in_plate: Array[CookingIngredient]) -> bool:
  var utils: CookingUtils= CookingUtils.new(in_plate)
  
  return utils.is_ingredients_same(_recipe(), in_plate)
  
