extends Node

#events start with _+number, the d, g is injected in EventArea.
func _1(d: Callable, g: GameEvent):
  GameState.lever_pulled.emit()
  
# This will be called when player leave the area, if 'trigger_by_enter is set to true.
func _1_after(d: EventUniqueData, g: GameEvent):
  pass
  
