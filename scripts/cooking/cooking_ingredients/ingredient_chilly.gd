extends CookingIngredient
class_name IngredientChilly

func _id() -> String:
  return 'chilly'

func _is_can_place(in_plate: Array[CookingIngredient]) -> bool:
  return true
  
