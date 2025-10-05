extends Node

enum ItemState{
  CAN_USE,
  CAN_DROP,
  CAN_GIVE
}

enum Variable{
  IS_DONE_SOMETHING,
}

#SAVE
var game_vars ={
  Variable.IS_DONE_SOMETHING: true,
}
var item_correct_id: int= DB.Food.PACK_OF_TOFU

#SAVE
var item_state: ItemState= ItemState.CAN_DROP

func set_var(id: Variable, value):
  game_vars[id]= value

func get_var(id: Variable):
  return game_vars[id]
