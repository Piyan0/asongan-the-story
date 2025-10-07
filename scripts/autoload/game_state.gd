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
var game_vars ={
  GameVar.IS_DONE_SOMETHING: true,
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

func current_used_inventory_slot() -> int:
  return DB.inventory_items.size()
  
func is_inventory_slot_available() -> bool:
  #return false
  return current_used_inventory_slot() < INVENTORY_MAX
  
