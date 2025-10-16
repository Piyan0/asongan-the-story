extends Node

func _1(d: Callable, g: GameEvent):
  if not GameState.can_enter_other_area:
    #print(1)
    Mediator.air(Mediator.PLAYER_CANT_ENTER_OTHER_AREA)
    return
    
  await g.change_scene(load(d.call().scene), OverlayManager.get_tree(), d.call().spawn_position)

func _2(d, g):
  pass
