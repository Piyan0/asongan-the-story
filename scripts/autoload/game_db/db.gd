extends Node
class_name ItemDB

enum Item{
  PACK_OF_TOFU= 0,
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

#SAVE
var shop_items= {
  Ingredient.TOFU: {
    'stock': 0,
    'item_name': 'TOFU',
    'cost': 99,
    'owned':0,
    'is_available': true
  },
  Ingredient.RICE_ROLL: {
    'stock': 0,
    'item_name': 'RICE_ROLL',
    'cost': 99,
    'owned':0,
    'is_available': true
  } ,
  Ingredient.COFFE_POWDER: {
    'stock': 20,
    'item_name': 'COFFE_POWDER',
    'cost': 99,
    'owned':10,
    'is_available': true
  } ,
  Ingredient.CHILLY: {
    'stock': 5,
    'item_name': 'CHILLY',
    'cost': 990,
    'owned':0,
    'is_available': true
  } ,
  Upgrade.COFFE_STAND:{
    'stock': 0,
    'item_name': 'COFFE_STAND',
    'cost': 99,
    'owned':0,
    'is_available': true
  } ,
  Upgrade.ITEM_SLOT_3:{
    'stock': 0,
    'item_name': 'ITEM_SLOT_3',
    'cost': 99,
    'owned':0,
    'is_available': true
  } ,
  Upgrade.ITEM_SLOT_5:{
    'stock': 0,
    'item_name': 'ITEM_SLOT_5',
    'cost': 99,
    'owned':0,
    'is_available': true
  } ,
}
