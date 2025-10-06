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
  'cost': 99,
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
    'cost': 99999,
  },
  Food.COFFE: {
    'item_type': ItemType.FOOD,
    'icon': "res://assets/sprites/items/coffe.png",
    'item_name': 'COFFE',
    'id': Food.COFFE,
    'worth': 99,
    'cost': 9999,
  },
}

#SAVE
var shop_items= [
  get_item_shop({
    'id': Food.COFFE,
  }),
  get_item_shop({
    'id': Food.PACK_OF_TOFU,
    'stock': 0,
  }),
]


#SAVE
var inventory_items= [
  get_item(Food.PACK_OF_TOFU, {}),
  get_item(Food.COFFE, {}),
]

func get_item(id: int, params= {}):
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
  inventory_items.erase(target)

func set_item_shop(id: int, params= {}):
  var item: Dictionary
  for i in shop_items:
    if i.id== id:
      item= i
  for i in params:
    item[i]= params[i]
