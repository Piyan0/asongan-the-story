extends Node
class_name Cooking

signal food_finished(food: CookingFood)

var _ingredient_placed= func(ingredient: CookingIngredient): pass
var _no_ingredient= func(): pass
var _food_finished= func(food: DB.Food): pass
var possible_food: Array[CookingFood]
var current_in_plate: Array[CookingIngredient]
var is_food_finished: bool= false

var ingredients_available: Array[CookingIngredient]


func place_ingredient(ingredient: CookingIngredient) -> bool:
  if is_food_finished: return false
  if not has_ingredient(ingredient._id()): 
    _no_ingredient.call()
    return false
  if not ingredient._is_can_place(current_in_plate):
    return false
  
  _ingredient_placed.call(ingredient._id())
  current_in_plate.push_back(ingredient)
  erase_ingredient(ingredient._id())
  for i in possible_food:
    if i.is_done(current_in_plate):
      event_food_finished(i._id())
  return true

func get_ingredient(id: int) -> CookingIngredient:
  for i in ingredients_available:
    if i._id()== id:
      return i
      
  return null
func event_food_finished(food_id: DB.Food) -> void:
  is_food_finished= true
  _food_finished.call(food_id)

func erase_ingredient(id: int):
  var to_delete
  for i in ingredients_available:
    if i._id()== id:
      to_delete= i
      break
  ingredients_available.erase(to_delete)
    

func has_ingredient(id: int) -> bool:
  if ingredients_available.is_empty(): return false
  for i in ingredients_available:
    if i._id()== id:
      return true
  
  return false
func get_available_ingredients() -> Array[CookingIngredient]:
  return ingredients_available
