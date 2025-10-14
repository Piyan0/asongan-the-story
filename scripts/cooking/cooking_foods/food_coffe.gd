extends CookingFood
class_name FoodCoffe

func _id() -> int:
  return DB.Food.COFFE

func _recipe() -> Array[CookingIngredient]:
  return [
    IngredientSpoon.new(),
    IngredientCoffePowder.new(),
    IngredientWater.new(),
  ]
  
  
