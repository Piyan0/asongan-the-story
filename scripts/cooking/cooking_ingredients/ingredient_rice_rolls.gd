extends CookingIngredient
class_name IngredientRiceRoll

func _id() -> int:
  return DB.Ingredient.RICE_ROLL

func _is_can_place(in_plate: Array[CookingIngredient]) -> bool:
  var utils: CookingUtils= CookingUtils.new(in_plate)
  
  return [
    utils.ingredients_count(DB.Ingredient.TOFU) <= 3,
    utils.ingredients_count(DB.Ingredient.RICE_ROLL) == 0,
    ].all(func(n): return n)
