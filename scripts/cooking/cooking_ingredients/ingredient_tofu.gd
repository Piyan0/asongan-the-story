class_name IngredientTofu
extends CookingIngredient

func _id() -> String:
  return 'tofu'
  
func _is_can_place(in_plate: Array[CookingIngredient]) -> bool:
  return true
