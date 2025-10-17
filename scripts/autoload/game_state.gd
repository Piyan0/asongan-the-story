extends Node

signal car_lined()
signal lever_pulled()
enum Visible{
  MAIN_ROAD_001,
  MAIN_ROAD_002,
}
enum ItemState{
  CAN_USE,
  CAN_DROP,
  CAN_GIVE
}

enum GameVar{
  IS_DONE_SOMETHING,
}

var food_request: Array[DB.Food]= []
var saved_setting_index= {}
var is_game_paused= false
#SAVE
var visible_state= {
  Visible.MAIN_ROAD_001: true,
  Visible.MAIN_ROAD_002: false,
}
#SAVE
var events_id : Dictionary = {
  EventsID.ID.NONE: '_1',
  EventsID.ID.MAIN_ROAD_001: '_1',
  EventsID.ID.MAIN_ROAD_002: '_1',
  EventsID.ID.MAIN_ROAD_003: '_1',
  EventsID.ID.MAIN_ROAD_004: '_1',
  EventsID.ID.MAIN_ROAD_005: '_1',
  EventsID.ID.MAIN_ROAD_006: '_1',
  
  EventsID.ID.SHOP_001: '_1',
  EventsID.ID.SHOP_002: '_1',
  EventsID.ID.SHOP_003: '_1',
  EventsID.ID.SHOP_004: '_1',
  EventsID.ID.SHOP_005: '_1',
  
}

var is_buyer_fulfilled: bool= false
var is_last_item_correct= false
#SAVE
var can_enter_other_area:bool= true
#SAVE
var game_vars ={
  GameVar.IS_DONE_SOMETHING: false,
}

var item_correct_id: int= -1

#SAVE
var item_state: ItemState= ItemState.CAN_DROP

#SAVE
var current_coin: int= 4

const INVENTORY_MAX := 16


func set_event(id: EventsID.ID, event: int):
  events_id[id]= '_'+str(event)
  
  
func get_item_status() -> bool:
  var _temp= is_last_item_correct
  #print_debug(_temp)
  is_last_item_correct= false
  return _temp
  
  
func set_var(id: GameVar, value):
  game_vars[id]= value

func get_var(id: GameVar):
  return game_vars[id]

func increment_var(id: GameVar):
  game_vars[id]+= 1

func get_current_used_inventory_slot() -> int:
  return DB.inventory_items.size()
  
func is_inventory_slot_available(exlude: int= 0) -> bool:
  #return false
  return get_current_used_inventory_slot()- exlude < INVENTORY_MAX

func minus_coin(by: int):
  current_coin-= by

func set_visible(id: Visible, is_on: bool):
  visible_state[id]= is_on


func is_money_enough():
  if food_request.is_empty():
    return true
    
  var coin= current_coin
  var request= []
  for i in food_request:
    request.push_back(
      coin >= Cooking.food_cost(DB.food_from_id(i))
    )
  
  return request.all(func(i): return i)
