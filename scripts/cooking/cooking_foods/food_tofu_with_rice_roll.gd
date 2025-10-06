extends CookingFood
class_name FoodTofuWithRiceRoll

func _id() -> int:
  return DB.Food.TOFU_WITH_RICE_ROLL

func _recipe() -> Array[CookingIngredient]:
  return[
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientChilly.new(),
    IngredientChilly.new(),
    IngredientChilly.new(),
    IngredientRiceRoll.new(),
  ]
