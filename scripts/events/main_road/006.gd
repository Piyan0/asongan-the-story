extends Node

#events start with _+number, the d, g is injected in EventArea.
func _1(d: Callable, g: GameEvent):
  if not GameState.can_pull_lever:
    return
  
  if GameState.food_request.is_empty():
    GameState.lever_pulled.emit()
    GameState.is_buyer_fulfilled= false
    return
    
  if GameState.is_buyer_fulfilled:
    GameState.lever_pulled.emit()
    GameState.is_buyer_fulfilled= false
  else:
    print('buyer is not satisfied.')
  
# This will be called when player leave the area, if 'trigger_by_enter is set to true.
func _1_after(d: EventUniqueData, g: GameEvent):
  pass
  
