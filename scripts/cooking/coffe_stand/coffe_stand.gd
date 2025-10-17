extends Control

enum CupState{
  IDLE= 1,
  POWDERED,
  STIRRED,
  WATERED,
}

var cup_images_path= {
  CupState.IDLE: "res://assets/sprites/cooking/coffe_stand/cup_idle.png",
  CupState.WATERED: "res://assets/sprites/cooking/coffe_stand/cup_watered.png",
  CupState.POWDERED: "res://assets/sprites/cooking/coffe_stand/cup_added_powder.png",
  CupState.STIRRED: "res://assets/sprites/cooking/coffe_stand/cup_with_coffe.png",
}

@onready var cup: TextureRect = %cup
@onready var food_finished: Control = $FoodFinished
@onready var prevent_input: ColorRect = $prevent_input

var cooking: Cooking
var ingredient_ui: Dictionary
var is_idle= true
var can_close= true
func _ready() -> void:
  #TranslationServer.set_locale('id-ID')
  ingredient_ui= {
    DB.Ingredient.WATER: %water,
    DB.Ingredient.SPOON: %spoon,
    DB.Ingredient.COFFE_POWDER: %coffe_powder,
  }
  
  if is_main():
    prepare()
  else:
    set_process(false)
    set_process_input(false)

func prepare():
  set_process_input(true)
  set_process(true)
  if has_spoon():
    ingredient_ui[DB.Ingredient.SPOON].set_count(1)
  else:
    ingredient_ui[DB.Ingredient.SPOON].set_count(0)
    
  cooking= Cooking.new()
  cooking.possible_food= [
    FoodCoffe.new()
  ]
  cooking.possible_ingredients= [
    IngredientSpoon.new(),
    IngredientCoffePowder.new(),
    IngredientWater.new(),
  ]
  cooking.set_up()
  cooking._food_finished= on_food_finished
  cooking._ingredient_placed= on_ingredient_placed
  cooking._resetted= on_resetted
  cooking._unable_to_place= on_unable_to_place
  cooking._no_ingredient= on_no_ingredient
  #cooking._is_can_place= GameState.is_inventory_slot_available
  coffe_stand_slider._looped= on_slider_looped
  food_finished._food_taken= on_food_taken
  fill(cooking)


func on_no_ingredient():
  OverlayManager.show_alert('NO_INGREDIENT')
  
  
func on_food_taken():
  OverlayManager.get_alert().close()
  await food_finished.close()
  change_cup_state(CupState.IDLE)
  can_close= true


func get_can_close() -> bool:
  return can_close
  

func on_food_finished(id: DB.Food) -> void:
  is_idle= false
  coffe_state.hide()
  await get_tree().create_timer(0.2).timeout
  DB.add_item_to_inventory(id)
  #cooking.ingredients_used_count
  match id:
    DB.Food.COFFE:
      await food_finished.play(load("res://assets/sprites/items/coffe.png"), 'COFFE')
     
  await OverlayManager.show_alert('CLICK_TO_CONTINUE', false)
  is_idle= true
  
  if is_main():
    return
    
  for i in cooking.ingredients_used_count[DB.Ingredient.WATER]:
    DB.erase_inventory_item(DB.Ingredient.WATER)
  for i in cooking.ingredients_used_count[DB.Ingredient.COFFE_POWDER]:
    DB.erase_inventory_item(DB.Ingredient.COFFE_POWDER)


func has_spoon() -> bool:
  if is_main():
    return true
  
  return DB.Upgrade.COFFE_STAND_SPOON in DB.upgrade_acquired
  
  
@onready var coffe_stand_slider: Control = %coffe_stand_slider

func on_ingredient_placed(id: DB.Ingredient) -> void:
  #print(1)
  #cooking.ingredients_used_count[id]+= 1
  match id:
    DB.Ingredient.COFFE_POWDER:
      ingredient_ui[id].decrement_count()
      change_cup_state(CupState.POWDERED)
    DB.Ingredient.WATER:
      ingredient_ui[id].decrement_count()
      change_cup_state(CupState.WATERED)
    DB.Ingredient.SPOON:
      pass

func on_resetted():
  if coffe_stand_slider.visible:
    coffe_stand_slider.set_succed(false)
    coffe_stand_slider.slide_finished.emit()
    await coffe_stand_slider.close()
    prevent_input.hide()
    coffe_stand_slider.hide()
    
  coffe_state.modulate= Color('ffffff00')
  coffe_state.hide()
  ingredient_ui[DB.Ingredient.COFFE_POWDER].set_count(ingredient_ui[DB.Ingredient.COFFE_POWDER].get_current_count()+ cooking.ingredients_used_count[DB.Ingredient.COFFE_POWDER])
  ingredient_ui[DB.Ingredient.WATER].set_count(ingredient_ui[DB.Ingredient.WATER].get_current_count()+ cooking.ingredients_used_count[DB.Ingredient.WATER])
  
  for i in cooking.ingredients_used_count:
    cooking.ingredients_used_count[i]= 0
   
  change_cup_state(CupState.IDLE)

func is_main():
  
  return get_tree().current_scene== self
  
  
func fill(_cooking: Cooking):
  if is_main():
    _cooking.ingredients_available.push_back(IngredientCoffePowder.new())
    _cooking.ingredients_available.push_back(IngredientWater.new())
    
    ingredient_ui[DB.Ingredient.WATER].set_count(1)
    ingredient_ui[DB.Ingredient.COFFE_POWDER].set_count(1)
    
    for i in ingredient_ui:
      ingredient_ui[i]._clicked= ingredient_clicked.bind(i)
    
    return
    
  var water_count= DB.get_item_count(DB.Ingredient.WATER)
  var coffe_powder_count= DB.get_item_count(DB.Ingredient.COFFE_POWDER)

  
  ingredient_ui[DB.Ingredient.WATER].set_count(water_count)
  ingredient_ui[DB.Ingredient.COFFE_POWDER].set_count(coffe_powder_count)
  
  for i in ingredient_ui:
    ingredient_ui[i]._clicked= ingredient_clicked.bind(i)
    
  for i in water_count:
    _cooking.ingredients_available.push_back(IngredientWater.new())
  for i in coffe_powder_count:
    _cooking.ingredients_available.push_back(IngredientCoffePowder.new())

func change_cup_state(state: CupState):
  cup.texture= load(cup_images_path[state])

  
func ingredient_clicked(id: DB.Ingredient):
  match id:
    DB.Ingredient.WATER:
      cooking.place_ingredient(IngredientWater.new())
    DB.Ingredient.COFFE_POWDER:
      cooking.place_ingredient(IngredientCoffePowder.new())
    DB.Ingredient.SPOON:
      var water_and_coffe_powder= cooking.is_ingredient_placed(DB.Ingredient.WATER) and cooking.is_ingredient_placed(DB.Ingredient.COFFE_POWDER)
      if not water_and_coffe_powder: return
      if not has_spoon(): 
        OverlayManager.show_alert('NO_SPOON')
        return
      prevent_input.show()
      coffe_stand_slider.start()
      await coffe_stand_slider.slide_finished
      can_close= false
      if not coffe_stand_slider.is_succed:
        return
      
      cooking.force_finish(FoodCoffe.new())
      change_cup_state(CupState.STIRRED)
      
      #print_debug(1)
      prevent_input.hide()
      

@onready var mouse: TextureRect = $mouse

#add an info used items.
func close():
  set_process(false)
  set_process_input(false)
  cooking.reset()
  change_cup_state(CupState.IDLE)

func on_unable_to_place() -> void:
  OverlayManager.show_alert('INVENTORY_MAXED')
  
func _process(delta: float) -> void:
  #print(can_close)
  mouse.position= get_global_mouse_position()

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("c") and self.visible:
    if coffe_stand_slider.is_idle:
      cooking.reset(coffe_stand_slider.visible)
    else:
      pass
      #print_debug('busy.')

@onready var coffe_state: TextureRect = %coffe_state

  
func on_slider_looped(count: int):
  coffe_state.show()
  coffe_state.modulate= Color('ffffff00')
  match count:
    1:
      coffe_state.modulate= Color('ffffff8b')
    2:
      coffe_state.modulate= Color('ffffff')
      
