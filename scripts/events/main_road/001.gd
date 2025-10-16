extends Node

#events start with _+number, the d, g is injected in EventArea.
func _1(d: Callable, g: GameEvent):
  await g.change_scene(load(d.call().scene), OverlayManager.get_tree(), d.call().spawn_position)

func _2(d: Callable, g: GameEvent):
  await OverlayManager.show_overlay(
    OverlayManager.Overlay.SHOP
  )
  
  
