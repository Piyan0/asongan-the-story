extends Node
class_name Cooking

signal food_finished(food: CookingFood)

var _ingredient_placed= func(ingredient: CookingIngredient): pass
var _no_ingredient= func(): pass
var _food_finished= func(food: DB.Food): pass
var _resetted= func(): pass
var _unable_to_place = func(): pass
var _is_can_place= func() -> bool: return true
var possible_food: Array[CookingFood]
var possible_ingredients: Array[CookingIngredient]
var current_in_plate: Array[CookingIngredient]
var is_food_finished: bool= false
var ingredients_used_count: Dictionary[int, int]
var ingredients_available: Array[CookingIngredient]


func set_up():
  if not ingredients_used_count:
    for i in possible_ingredients:
      ingredients_used_count[i._id()]= 0
  

func place_ingredient(ingredient: CookingIngredient, take_from_available: bool= true) -> bool:

  if not _is_can_place.call():
    _unable_to_place.call()
    return false
    
  if is_food_finished: return false
  if not has_ingredient(ingredient._id()) and take_from_available: 
    _no_ingredient.call()
    #print('nooo')
    return false
  if not ingredient._is_can_place(current_in_plate):
    return false
  
  _ingredient_placed.call(ingredient._id())
  current_in_plate.push_back(ingredient)

  ingredients_used_count[ingredient._id()]+= 1
  #print_debug(ingredients_used_count)
  erase_ingredient(ingredient._id())
  for i in possible_food:
    if i.is_done(current_in_plate):
      await event_food_finished(i._id())
      start_over()
      for j in ingredients_used_count:
        ingredients_used_count[j]= 0
  return true


func start_over() -> void:
  is_food_finished= false
  current_in_plate= []
 
 
func get_ingredient(id: int) -> CookingIngredient:
  for i in ingredients_available:
    if i._id()== id:
      return i
      
  return null


func event_food_finished(food_id: DB.Food) -> void:
  is_food_finished= true
  await _food_finished.call(food_id)


func erase_ingredient(id: int):
  var to_delete

  for i in ingredients_available:
    if i._id()== id:
      to_delete= i
      break
  ingredients_available.erase(to_delete)
    
    
func is_ingredient_placed(id: int) -> bool:
  if current_in_plate.is_empty(): return false
  for i in current_in_plate:
    if i._id()== id:
      return true
  
  return false


func has_ingredient(id: int) -> bool:
  if ingredients_available.is_empty(): return false
  for i in ingredients_available:
    if i._id()== id:
      return true
  
  return false
  
  
func get_available_ingredients() -> Array[CookingIngredient]:
  return ingredients_available


func reset(force= false):
  if not force and current_in_plate.is_empty() or is_food_finished:
    return
  for i in current_in_plate:
    ingredients_available.push_back(i)
  
  await _resetted.call()
  current_in_plate= []
  for i in ingredients_used_count:
    ingredients_used_count[i]= 0


func in_plate_count() -> int:
  return current_in_plate.size()


static func food_cost(food: CookingFood) -> float:
  var ingredients: Array[CookingIngredient]= food._recipe()
  var cost: int= 0
  for i in ingredients:
    var item= DB.get_item(i._id())
    cost+= item.cost
  
  return cost
  

static func is_ingredients_can_make_food(ingredients: Array[CookingIngredient], foods: Array[CookingFood]) -> bool:
  if foods.is_empty():
    return true
    
  var utils= CookingUtils.new([])
  var foods_can_be_cooked: Array[CookingFood]
  for i in foods:
    var is_enough= utils.is_ingredients_enough(ingredients, i)
    if is_enough:
      foods_can_be_cooked.push_back(i)
    else:
      pass
  
  for i in foods_can_be_cooked:
    print(i._id())
  return foods_can_be_cooked.size()> 0
      
  
  
  
  
