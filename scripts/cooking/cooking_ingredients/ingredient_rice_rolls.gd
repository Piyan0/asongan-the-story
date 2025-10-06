extends CookingIngredient
class_name IngredientRiceRoll

func _id() -> int:
  return DB.Ingredient.RICE_ROLL

func _is_can_place(in_plate: Array[CookingIngredient]) -> bool:
  var utils: CookingUtils= CookingUtils.new(in_plate)
  
  return utils.is_plate_contains_less_than_or_same(DB.Ingredient.TOFU, 3, in_plate)
