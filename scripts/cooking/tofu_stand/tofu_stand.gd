extends Control
class_name TofuStand

@onready var tofus= [
  $Control/tofu/TextureRect, $Control/tofu/TextureRect2, $Control/tofu/TextureRect3, $Control/tofu/TextureRect4, $Control/tofu/TextureRect5, $Control/tofu/TextureRect6
]
@onready var rice_roll: TextureRect = $Control/tofu/rice_roll
var cooking: Cooking
var ingredient_ui: Dictionary
var current_tofu: int= 0

func _ready() -> void:
  TranslationServer.set_locale('id-ID')
  ingredient_ui= {
    DB.Ingredient.TOFU: %tofu,
    DB.Ingredient.RICE_ROLL: %rice_roll,
    DB.Ingredient.CHILLY: %chilly,
  }
  
  prepare()

func prepare():
  cooking= Cooking.new()
  cooking.possible_food= [
    FoodPackOfTofu.new(),
    FoodTofuWithRiceRoll.new(),
  ]
  cooking._food_finished= on_food_finished
  cooking._ingredient_placed= on_ingredient_placed
  fill(cooking)

func on_food_finished(id: DB.Food) -> void:
  await get_tree().create_timer(0.2).timeout
  match id:
    DB.Food.PACK_OF_TOFU:
      $FoodFinished.play(load("res://assets/sprites/items/tofu.png"), 'PACK_OF_TOFU')
    DB.Food.TOFU_WITH_RICE_ROLL:
      $FoodFinished.play(load("res://assets/sprites/items/tofu_extra.png"), 'TOFU_EXTRA')

      
  
func on_ingredient_placed(id: DB.Ingredient) -> void:
  #print(1)
  ingredient_ui[id].decrement_count()
  match id:
    DB.Ingredient.TOFU:
      add_tofu()
    DB.Ingredient.RICE_ROLL:
      add_rice_roll()
    DB.Ingredient.CHILLY:
      pass
    
  
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

func ingredient_clicked(id: DB.Ingredient):
  match id:
    DB.Ingredient.TOFU:
      cooking.place_ingredient(IngredientTofu.new())
    DB.Ingredient.RICE_ROLL:
      cooking.place_ingredient(IngredientRiceRoll.new())
    DB.Ingredient.CHILLY:
      cooking.place_ingredient(IngredientChilly.new())
      

@onready var mouse: TextureRect = $mouse

func _physics_process(delta: float) -> void:
  mouse.position= get_global_mouse_position()
