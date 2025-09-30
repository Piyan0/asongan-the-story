extends Node
class_name TofuStandManager

var instance: TofuStandManager
var child_instance: TofuStand
var cooking: Cooking

func _ready() -> void:
  cooking= Cooking.new()
  
  cooking.possible_food= [
    FoodTofu.new(), FoodTofuExtra.new()
  ]
  
  cooking.ingredients_owned= [

    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientTofu.new(),
    IngredientRiceRolls.new()
  ]
  
  if not instance:
    instance= self
  
  await get_tree().process_frame
  child_instance= get_tree().get_first_node_in_group('TofuStand')
  wire()

func display_ingredient_count(ui: Ingredient):
  var count: int= 0
  for i in cooking.get_available_ingredients():
    if i._id()== ui.id:
      count+= 1
  ui.set_count(count)
  
func wire():
  for i:Ingredient in child_instance.get_ingredient_list():
    display_ingredient_count(i)
    i.ingredient_used.connect(on_Ingredient_item_used)


func on_Ingredient_item_used(id: String, instance: Ingredient):
  var ingredient: CookingIngredient
  var callback: Callable
  match id:
    'tofu':
      ingredient= IngredientTofu.new()
      callback= child_instance.add_tofu
    'rice_rolls':
      ingredient= IngredientRiceRolls.new()
      callback= child_instance.add_rice_rolls
    
  var place: bool= cooking.place_ingredient(ingredient)
  
  if place:
    callback.call()
    display_ingredient_count(instance)
  else:
    pass
  

func on_ingredient_empty():
  pass
  print('empty')
