extends Control
class_name TofuStand

@onready var tofus= [
  $Control/tofu/TextureRect, $Control/tofu/TextureRect2, $Control/tofu/TextureRect3, $Control/tofu/TextureRect4, $Control/tofu/TextureRect5, $Control/tofu/TextureRect6
]
@onready var rice_roll: TextureRect = $Control/tofu/rice_roll
@onready var food_finished: Control = $FoodFinished

var cooking: Cooking
var ingredient_ui: Dictionary
var current_tofu: int= 0
#var cooking.ingredients_used_count: Dictionary

func _ready() -> void:
  TranslationServer.set_locale('id-ID')
  ingredient_ui= {
    DB.Ingredient.TOFU: %tofu,
    DB.Ingredient.RICE_ROLL: %rice_roll,
    DB.Ingredient.CHILLY: %chilly,
  }
  
  
  if get_tree().current_scene== self:
    prepare()

func prepare():
  #cooking.ingredients_used_count= {
    #DB.Ingredient.TOFU: 0,
    #DB.Ingredient.RICE_ROLL: 0,
    #DB.Ingredient.CHILLY: 0,
  #}
  
  cooking= Cooking.new()
  cooking.possible_food= [
    FoodPackOfTofu.new(),
    FoodTofuWithRiceRoll.new(),
  ]
  cooking.possible_ingredients= [
    IngredientTofu.new(),
    IngredientChilly.new(),
    IngredientRiceRoll.new()
  ]
  cooking._food_finished= on_food_finished
  cooking._ingredient_placed= on_ingredient_placed
  cooking._resetted= on_resetted
  cooking._unable_to_place= on_unable_to_place
  cooking._no_ingredient= on_no_ingredient
  #cooking._is_can_place= GameState.is_inventory_slot_available
  
  food_finished._food_taken= on_food_taken
  fill(cooking)

func on_no_ingredient():
  OverlayManager.show_alert('NO_INGREDIENT')
  
func on_food_taken():
  OverlayManager.get_alert().close()
  food_finished.close()
  hide_all()
  #cooking.is_food_finished= false

func on_food_finished(id: DB.Food) -> void:

  await get_tree().create_timer(0.2).timeout
  DB.add_item_to_inventory(id)
  #cooking.ingredients_used_count
  match id:
    DB.Food.PACK_OF_TOFU:
      await food_finished.play(load("res://assets/sprites/items/tofu.png"), 'PACK_OF_TOFU')
      
    DB.Food.TOFU_WITH_RICE_ROLL:
      await food_finished.play(load("res://assets/sprites/items/tofu_extra.png"), 'TOFU_WITH_RICE_ROLL')
     
  OverlayManager.show_alert('CLICK_TO_CONTINUE', false)
  for i in cooking.ingredients_used_count[DB.Ingredient.TOFU]:
    DB.erase_inventory_item(DB.Ingredient.TOFU)
  for i in cooking.ingredients_used_count[DB.Ingredient.RICE_ROLL]:
    DB.erase_inventory_item(DB.Ingredient.RICE_ROLL)
  for i in cooking.ingredients_used_count[DB.Ingredient.CHILLY]:
    DB.erase_inventory_item(DB.Ingredient.CHILLY)
  
  #print(DB.inventory_items)
  #print( DB.get_item_count(DB.Ingredient.TOFU) )
      
  
func on_ingredient_placed(id: DB.Ingredient) -> void:
  #print(1)
  ingredient_ui[id].decrement_count()
  #cooking.ingredients_used_count[id]+= 1
  match id:
    DB.Ingredient.TOFU:
      add_tofu()
    DB.Ingredient.RICE_ROLL:
      add_rice_roll()
    DB.Ingredient.CHILLY:
      pass

func on_resetted():
  ingredient_ui[DB.Ingredient.TOFU].set_count(ingredient_ui[DB.Ingredient.TOFU].get_current_count()+ cooking.ingredients_used_count[DB.Ingredient.TOFU])
  ingredient_ui[DB.Ingredient.CHILLY].set_count(ingredient_ui[DB.Ingredient.CHILLY].get_current_count()+ cooking.ingredients_used_count[DB.Ingredient.CHILLY])
  ingredient_ui[DB.Ingredient.RICE_ROLL].set_count(ingredient_ui[DB.Ingredient.RICE_ROLL].get_current_count()+ cooking.ingredients_used_count[DB.Ingredient.RICE_ROLL])
  
  for i in cooking.ingredients_used_count:
    cooking.ingredients_used_count[i]= 0
   
  hide_all()
  
func fill(_cooking: Cooking):
  var tofu_count= DB.get_item_count(DB.Ingredient.TOFU)
  var chilly_count= DB.get_item_count(DB.Ingredient.CHILLY)
  var rice_roll_count= DB.get_item_count(DB.Ingredient.RICE_ROLL)
  
  ingredient_ui[DB.Ingredient.TOFU].set_count(tofu_count)
  ingredient_ui[DB.Ingredient.CHILLY].set_count(chilly_count)
  ingredient_ui[DB.Ingredient.RICE_ROLL].set_count(rice_roll_count)
  
  for i in ingredient_ui:
    ingredient_ui[i]._clicked= ingredient_clicked.bind(i)
    
  for i in tofu_count:
    _cooking.ingredients_available.push_back(IngredientTofu.new())
  for i in chilly_count:
    _cooking.ingredients_available.push_back(IngredientChilly.new())
  for i in rice_roll_count:
    _cooking.ingredients_available.push_back(IngredientRiceRoll.new())
  

func add_tofu():
  var i = tofus[current_tofu]
  i.show()
  i.get_child(0).play('new_animation')
  
  current_tofu+= 1

func add_rice_roll():
  rice_roll.show()
  rice_roll.get_child(0).play('new_animation')

func hide_all():
  for i in tofus:
    i.hide()
  current_tofu= 0
  rice_roll.hide()
func ingredient_clicked(id: DB.Ingredient):
  match id:
    DB.Ingredient.TOFU:
      cooking.place_ingredient(IngredientTofu.new())
    DB.Ingredient.RICE_ROLL:
      cooking.place_ingredient(IngredientRiceRoll.new())
    DB.Ingredient.CHILLY:
      cooking.place_ingredient(IngredientChilly.new())
      

@onready var mouse: TextureRect = $mouse

#add an info used items.
func close():
  cooking.reset()

func on_unable_to_place() -> void:
  OverlayManager.show_alert('INVENTORY_MAXED')
  
func _process(delta: float) -> void:
  mouse.position= get_global_mouse_position()

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("c"):
    #print(1)
    cooking.reset()
