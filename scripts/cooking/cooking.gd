extends Node
class_name Cooking

signal food_finished(food: CookingFood)

var possible_food: Array[CookingFood]
var current_in_plate: Array[CookingIngredient]
var is_food_finished: bool= false

#SAVE
static var ingredients_owned: Array[CookingIngredient]


func place_ingredient(ingredient: CookingIngredient) -> bool:
  if is_food_finished: return false
  if not has_ingredient(ingredient._id()): return false
  if not ingredient._is_can_place(current_in_plate):
    return false
    
  current_in_plate.push_back(ingredient)
  erase_ingredient(ingredient._id())
  for i in possible_food:
    if i.is_done(current_in_plate):
      event_food_finished(i)
  return true

func event_food_finished(food: CookingFood) -> void:
  is_food_finished= true
  food_finished.emit(food)

func erase_ingredient(id: String):
  var to_delete
  for i in ingredients_owned:
    if i._id()== id:
      to_delete= i
      break
  ingredients_owned.erase(to_delete)
    

func has_ingredient(id: String) -> bool:
  if ingredients_owned.is_empty(): return false
  for i in ingredients_owned:
    if i._id()== id:
      return true
  
  return false
func get_available_ingredients() -> Array[CookingIngredient]:
  return ingredients_owned
