extends Node
class_name CookingUtils

var in_plate: Array[CookingIngredient]

func _init(_in_plate: Array[CookingIngredient]) -> void:
  in_plate = _in_plate
  
  
func is_ingredients_same(ingredients_1: Array[CookingIngredient], ingredients_2: Array[CookingIngredient]) -> bool:
  if ingredients_1.is_empty() or ingredients_2.is_empty():
    return false
  
  var ingredient_1_map: Dictionary
  for i in ingredients_1:
    if i._id() in ingredient_1_map:
      ingredient_1_map[i._id()] += 1
    else:
      ingredient_1_map[i._id()] = 1
  
  var ingredient_2_map: Dictionary
  for i in ingredients_2:
    if i._id() in ingredient_2_map:
      ingredient_2_map[i._id()] += 1
    else:
      ingredient_2_map[i._id()] = 1
  
  printt(ingredient_1_map, ingredient_2_map)
  #check if keys is same.
  var keys_1 = ingredient_1_map.keys()
  var keys_2 = ingredient_2_map.keys()
  
  var is_keys_same = [
    keys_1.all(func(i): return i in keys_2),
    keys_2.all(func(i): return i in keys_1)
  ].all(func(i): return i)
  
  if not is_keys_same:
    return false
  
  #check if value is same.
  for i in ingredient_1_map:
    if ingredient_2_map[i] != ingredient_1_map[i]:
      return false

  return true


func is_plate_contains_less_than_or_same(id: DB.Ingredient, n: int, plate: Array[CookingIngredient]=in_plate) -> bool:
  var ingredient_count: int = 0
  for i in plate:
    if i._id() == id:
      ingredient_count += 1
  
  if ingredient_count == n:
    return false
  else:
    return true


func is_plate_contains_more_than(id: DB.Ingredient, at_least: int, plate: Array[CookingIngredient]=in_plate) -> bool:
  var ingredient_count: int = 0
  for i in plate:
    if i._id() == id:
      ingredient_count += 1
  
  if ingredient_count >= at_least:
    return true
  else:
    return false


func ingredients_count(id: DB.Ingredient, ingredients: Array[CookingIngredient]=in_plate):
  var ingredient_count: int = 0
  for i in ingredients:
    if i._id() == id:
      ingredient_count += 1
  
  return ingredient_count
  

func is_ingredients_enough(ingredients: Array[CookingIngredient], food: CookingFood) -> bool:
  for i in food._recipe():
    var ingredients_required: int = ingredients_count(i._id(), food._recipe())
    var ingredients_available: int = ingredients_count(i._id(), ingredients)
    if not ingredients_available >= ingredients_required:
      return false
  
  if not food._requirement().is_empty():
    var is_requirement_fulfilled = food._requirement().all(func(i): return i in DB.upgrade_acquired)
    if not is_requirement_fulfilled:
      return false
  return true
  
  
func is_only_contain_one_type(id: DB.Ingredient, plate: Array[CookingIngredient]=in_plate) -> bool:
  if plate.is_empty():
    return false
  for i in plate:
    if i._id() != id:
      return false
  
  return true
