extends Node

enum ItemState{
  CAN_USE,
  CAN_DROP,
  CAN_GIVE
}

enum GameVar{
  IS_DONE_SOMETHING,
}

#SAVE
var events_id : Dictionary = {
  EventsID.ID.MAIN_ROAD_001: '_1',
  EventsID.ID.MAIN_ROAD_002: '_1',
  EventsID.ID.MAIN_ROAD_003: '_1',
  EventsID.ID.MAIN_ROAD_004: '_1',
  EventsID.ID.MAIN_ROAD_005: '_1',
  
  EventsID.ID.SHOP_001: '_1',
  EventsID.ID.SHOP_002: '_1',
  EventsID.ID.SHOP_003: '_1',
  EventsID.ID.SHOP_004: '_1',
  EventsID.ID.SHOP_005: '_1',
  
}

#SAVE
var can_enter_other_area:bool= true
#SAVE
var game_vars ={
  GameVar.IS_DONE_SOMETHING: false,
}

var item_correct_id: int= DB.Food.PACK_OF_TOFU

#SAVE
var item_state: ItemState= ItemState.CAN_DROP

#SAVE
var current_coin: int= 200

const INVENTORY_MAX := 16

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
  
