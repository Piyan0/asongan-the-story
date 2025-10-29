extends Node

#events start with _+number, the d, g is injected in EventArea.
func _1(d: Callable, g: GameEvent):
  print('calling train.')
  #GameState.can_enter_other_area= false
  Mediator.air(Mediator.CAR_BATCH, [
    MainRoad.i.move_cars_from_dict(
    GameState.current_car_batch
  ), 10
  ])

func _2(d: Callable, g: GameEvent):
  GameState.set_event(
    EventsID.ID.MAIN_ROAD_AUTO, 1
  )
  GameEventQueue.pop()
  
  
# This will be called when player leave the area, if 'trigger_by_enter is set to true.
func _1_after(d: EventUniqueData, g: GameEvent):
  pass
  
