extends Node

enum ItemType {
  FOOD,
  INGREDIENT,
  STORY,
  UPGRADE,
}


enum Food {
  PACK_OF_TOFU = 50,
  TOFU_WITH_RICE_ROLL,
  COFFE,
}

# DEPENDENT Ingredient
enum Ingredient {
  TOFU = 100,
  RICE_ROLL,
  COFFE_POWDER,
  WATER,
  CHILLY,
  SPOON,
}

# DEPENDENT_CHILD Ingredient
var ingredients_class = {
  Ingredient.TOFU: IngredientTofu,
  Ingredient.RICE_ROLL: IngredientRiceRoll,
  Ingredient.COFFE_POWDER: IngredientCoffePowder,
  Ingredient.WATER: IngredientWater,
  Ingredient.CHILLY: IngredientChilly,
  Ingredient.SPOON: IngredientSpoon,
}

var foods_class = {
  Food.PACK_OF_TOFU: FoodPackOfTofu,
  Food.TOFU_WITH_RICE_ROLL: FoodTofuWithRiceRoll,
  Food.COFFE: FoodCoffe,
}

enum Upgrade {
  COFFE_STAND = 200,
  ITEM_SLOT_3,
  ITEM_SLOT_5,
  COFFE_STAND_SPOON,
}

var shop_item_template: Dictionary = {
  'id': Food.COFFE,
  'is_available': true,
  'owned': 0,
  'stock': 99,
}
var items = {
  Food.PACK_OF_TOFU: {
    'item_type': ItemType.FOOD,
    'icon': "res://assets/sprites/items/tofu.png",
    'item_name': 'PACK_OF_TOFU',
    'id': Food.PACK_OF_TOFU,
    'worth': 15,
    'cost': 13,
  },
  Food.TOFU_WITH_RICE_ROLL: {
    'item_type': ItemType.FOOD,
    'icon': "res://assets/sprites/items/tofu_extra.png",
    'item_name': 'TOFU_WITH_RICE_ROLL',
    'id': Food.TOFU_WITH_RICE_ROLL,
    'worth': 20,
    'cost': 15,
  },
  Food.COFFE: {
    'item_type': ItemType.FOOD,
    'icon': "res://assets/sprites/items/coffe.png",
    'item_name': 'COFFE',
    'id': Food.COFFE,
    'worth': 37,
    'cost': 19,
  },
  Ingredient.TOFU: {
    'item_type': ItemType.INGREDIENT,
    'icon': "res://assets/sprites/items/single_tofu.png",
    'item_name': 'TOFU',
    'id': Ingredient.TOFU,
    'worth': 0,
    'cost': 2,
  },
  Ingredient.RICE_ROLL: {
    'item_type': ItemType.INGREDIENT,
    'icon': "res://assets/sprites/items/rice_roll.png",
    'item_name': 'RICE_ROLL',
    'id': Ingredient.RICE_ROLL,
    'worth': 0,
    'cost': 8,
  },
  Ingredient.CHILLY: {
    'item_type': ItemType.INGREDIENT,
    'icon': "res://assets/sprites/items/chilly.png",
    'item_name': 'CHILLY',
    'id': Ingredient.CHILLY,
    'worth': 0,
    'cost': 1,
  },
  
  Ingredient.COFFE_POWDER: {
    'item_type': ItemType.INGREDIENT,
    'icon': "res://assets/sprites/items/coffe_powder.png",
    'item_name': 'COFFE_POWDER',
    'id': Ingredient.COFFE_POWDER,
    'worth': 0,
    'cost': 10,
  },
  
  Ingredient.WATER: {
    'item_type': ItemType.INGREDIENT,
    'icon': "res://assets/sprites/items/water.png",
    'item_name': 'WATER',
    'id': Ingredient.WATER,
    'worth': 0,
    'cost': 9,
  },
  
  Upgrade.COFFE_STAND_SPOON: {
    'item_type': ItemType.UPGRADE,
    'icon': "res://assets/sprites/items/upgrade.png",
    'item_name': 'SPOON',
    'id': Upgrade.COFFE_STAND_SPOON,
    'worth': 0,
    'cost': 65,
  },
}

#SAVE
var shop_items = [
  get_item_shop({
    'id': Ingredient.RICE_ROLL,
    'stock': 10,
  }),
  get_item_shop({
    'id': Ingredient.TOFU,
    'stock': 10,
  }),
  get_item_shop({
    'id': Ingredient.CHILLY,
    'stock': 10,
  }),
  get_item_shop({
    'id': Ingredient.COFFE_POWDER,
    'stock': 10,
  }),
  get_item_shop({
    'id': Ingredient.WATER,
    'stock': 10,
  }),
  #get_item_shop({
    #'id': Upgrade.COFFE_STAND_SPOON,
    #'stock': 10,
  #}),
]


#SAVE
var inventory_items = [
  # get_item(Food.PACK_OF_TOFU),
  #get_item(Food.PACK_OF_TOFU),
  get_item(Ingredient.COFFE_POWDER),
  get_item(Ingredient.WATER),
]

#SAVE 
var upgrade_acquired: Array[Upgrade] = [
  DB.Upgrade.COFFE_STAND_SPOON
]

func get_item(id: int, params={}):
  #print(id)
  var item = items[id].duplicate()
  for i in params:
    item[i] = params[i]
  return item.duplicate()


func get_item_shop(params={}):
  var item = shop_item_template.duplicate()
  for i in params:
    item[i] = params[i]
  return item.duplicate()

func erase_inventory_item(id: int):
  var target
  for i in inventory_items:
    if i.id == id:
      target = i
  if target:
    inventory_items.erase(target)
  
  #print(inventory_items)

func set_item_shop(id: int, params={}):
  var item: Dictionary
  for i in shop_items:
    if i.id == id:
      item = i
  for i in params:
    item[i] = params[i]

func get_inventory_item(id: int) -> Dictionary:
  for i in inventory_items:
    if i.id == id:
      return i
  
  return {}

func get_item_count(id: int) -> int:
  var count: int = 0
  #print(id)
  for i in inventory_items:
    if i.id == id:
      count += 1
  
  return count

func add_item_to_inventory(id: int):
  var item = get_item(id)
  if item.item_type == ItemType.UPGRADE:
    return
  inventory_items.push_back(
    item
  )


func upgrade_callback(id: Upgrade):
  match id:
    Upgrade.COFFE_STAND_SPOON:
      upgrade_acquired.push_back(DB.Upgrade.COFFE_STAND_SPOON)
      print('you bougth spoon.')
  
  
func food_from_id(id: Food) -> CookingFood:
  match id:
    Food.PACK_OF_TOFU:
      return FoodPackOfTofu.new()
    Food.TOFU_WITH_RICE_ROLL:
      return FoodTofuWithRiceRoll.new()
    Food.COFFE:
      return FoodCoffe.new()
    
  return
  
  
func get_ingredients(id: int) -> CookingIngredient:
  return ingredients_class[id].new()
  
func get_food_class(id: int) -> CookingFood:
  return foods_class[id].new()
    
    
func ingredients_from_shop() -> Array[CookingIngredient]:
  var arr: Array[CookingIngredient]
  for i in shop_items:
    if get_item(i.id).item_type == ItemType.INGREDIENT:
      for j in i.stock:
        arr.push_back(get_ingredients(i.id))
    
  return arr
    
    
func ingredients_from_inventory() -> Array[CookingIngredient]:
  var arr: Array[CookingIngredient] = []
  for i in inventory_items:
    if get_item(i.id).item_type == ItemType.INGREDIENT:
      arr.push_back(get_ingredients(i.id))

  return arr


func foods_from_inventory() -> Array[CookingFood]:
  var arr: Array[CookingFood] = []
  for i in inventory_items:
    if get_item(i.id).item_type == ItemType.FOOD:
      arr.push_back(get_food_class(i.id))

  return arr
  

func reset_stock() -> void:
  for i in shop_items:
    i.stock = 0


func set_stock_based_on_foods(foods: Array[CookingFood]) -> void:
  reset_stock()
  var new_stock: Dictionary[int, int]
  
  for i in foods:
    for j in i._recipe():
      if not j._id() in new_stock:
        new_stock[j._id()] = 0
      new_stock[j._id()] += 1

  var get_shop_items = func(id: int) -> Dictionary:
    for i in shop_items:
      if i.id == id:
        return i
    return Dictionary()

  for i in new_stock:
    #print(new_stock[i])
    get_shop_items.call(i).stock = new_stock[i]
