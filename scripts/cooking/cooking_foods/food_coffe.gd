extends CookingFood
class_name FoodCoffe

func _is_common() -> bool:
  return false
  
func _requirement() -> Array[DB.Upgrade]:
  return [DB.Upgrade.COFFE_STAND_SPOON]
  
  
func _id() -> int:
  return DB.Food.COFFE

func _recipe() -> Array[CookingIngredient]:
  return [
    IngredientCoffePowder.new(),
    IngredientWater.new(),
  ]
  
  
