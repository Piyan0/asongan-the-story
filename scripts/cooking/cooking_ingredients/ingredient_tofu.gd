class_name IngredientTofu
extends CookingIngredient

func _id() -> int:
  return DB.Ingredient.TOFU
  
func _is_can_place(in_plate: Array[CookingIngredient]) -> bool:
  return true
