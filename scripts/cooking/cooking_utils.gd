extends Node
class_name CookingUtils

func is_ingredients_same(ingredients_1: Array[CookingIngredient], ingredients_2: Array[CookingIngredient]) -> bool:
  if ingredients_1.is_empty() or ingredients_2.is_empty():
    return false
  
  var ingredient_1_map: Dictionary
  for i in ingredients_1:
    if i._id() in ingredient_1_map:
      ingredient_1_map[i._id()]+= 1
    else:
      ingredient_1_map[i._id()]= 1
  
  var ingredient_2_map: Dictionary
  for i in ingredients_2:
    if i._id() in ingredient_2_map:
      ingredient_2_map[i._id()]+= 1
    else:
      ingredient_2_map[i._id()]= 1
  
  #printt(ingredient_1_map, ingredient_2_map)
  for i in ingredient_1_map:
    if i not in ingredient_2_map:
      return false
    elif ingredient_2_map[i] != ingredient_1_map[i]:
      return false

  return true

func is_plate_contains_at_least(id: String, at_least: int, plate: Array[CookingIngredient]) -> bool:
  var ingredient_count: int= 0
  for i in plate:
    if i._id()== id:
      ingredient_count+= 1
  
  if ingredient_count<= at_least:
    #print(ingredient_count)
    return true
  else:
    return false

func is_plate_contains_more_than(id: String, at_least: int, plate: Array[CookingIngredient]) -> bool:
  var ingredient_count: int= 0
  for i in plate:
    if i._id()== id:
      ingredient_count+= 1
  
  if ingredient_count>= at_least:
    return true
  else:
    return false

func is_all_same(id: String, plate: Array[CookingIngredient]) -> bool:
  if plate.is_empty():
    return false
  for i in plate:
    if i._id()!= id:
      return false
  
  return true
