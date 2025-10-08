extends Node

enum ItemType{
  FOOD,
  INGREDIENT,
  STORY,
  UPGRADE,
}


enum Food{
  PACK_OF_TOFU= 50,
  TOFU_WITH_RICE_ROLL,
  COFFE,
}

enum Ingredient{
  TOFU= 100,
  RICE_ROLL,
  COFFE_POWDER,
  WATER,
  CHILLY,
}

enum Upgrade{
  COFFE_STAND= 200,
  ITEM_SLOT_3,
  ITEM_SLOT_5,
}

var shop_item_template: Dictionary= {
  'id': Food.COFFE,
  'is_available': true,
  'owned': 0,
  'stock': 99,
}
var items= {
  Food.PACK_OF_TOFU: {
    'item_type': ItemType.FOOD,
    'icon': "res://assets/sprites/items/tofu.png",
    'item_name': 'PACK_OF_TOFU',
    'id': Food.PACK_OF_TOFU,
    'worth': 99,
    'cost': 1,
  },
  Food.TOFU_WITH_RICE_ROLL: {
    'item_type': ItemType.FOOD,
    'icon': "res://assets/sprites/items/tofu.png",
    'item_name': 'TOFU_WITH_RICE_ROLL',
    'id': Food.TOFU_WITH_RICE_ROLL,
    'worth': 99,
    'cost': 99999,
  },
  Food.COFFE: {
    'item_type': ItemType.FOOD,
    'icon': "res://assets/sprites/items/coffe.png",
    'item_name': 'COFFE',
    'id': Food.COFFE,
    'worth': 99,
    'cost': 1,
  },
  Ingredient.TOFU: {
    'item_type': ItemType.INGREDIENT,
    'icon': "res://assets/sprites/items/coffe.png",
    'item_name': 'TOFU',
    'id': Ingredient.TOFU,
    'worth': 99,
    'cost': 9999,
  },
  Ingredient.RICE_ROLL: {
    'item_type': ItemType.INGREDIENT,
    'icon': "res://assets/sprites/items/coffe.png",
    'item_name': 'RICE_ROLL',
    'id': Ingredient.RICE_ROLL,
    'worth': 99,
    'cost': 1,
  },
  Ingredient.CHILLY: {
    'item_type': ItemType.INGREDIENT,
    'icon': "res://assets/sprites/items/coffe.png",
    'item_name': 'CHILLY',
    'id': Ingredient.CHILLY,
    'worth': 99,
    'cost': 9999,
  },
}

#SAVE
var shop_items= [
  get_item_shop({
    'id': Ingredient.RICE_ROLL,
    'stock': 10,
  }),
  get_item_shop({
    'id': Ingredient.TOFU,
    'stock': 10,
  }),
]


#SAVE
var inventory_items= [
]

func get_item(id: int, params= {}):
  #print(id)
  var item= items[id].duplicate()
  for i in params:
    item[i]= params[i]
  return item.duplicate()


func get_item_shop(params= {}):
  var item= shop_item_template.duplicate()
  for i in params:
    item[i]= params[i]
  return item.duplicate()

func erase_inventory_item(id: int):
  var target
  for i in inventory_items:
    if i.id== id:
      target= i
  if target:
    inventory_items.erase(target)
  
  #print(inventory_items)

func set_item_shop(id: int, params= {}):
  var item: Dictionary
  for i in shop_items:
    if i.id== id:
      item= i
  for i in params:
    item[i]= params[i]

func get_inventory_item(id: int) -> Dictionary:
  for i in inventory_items:
    if i.id == id:
      return i
  
  return {}

func get_item_count(id: int) -> int:
  var count: int= 0
  #print(id)
  for i in inventory_items:
    if i.id== id:
      count+= 1
  
  return count

func add_item_to_inventory(id: int):
  inventory_items.push_back(
    get_item(id)
  )
