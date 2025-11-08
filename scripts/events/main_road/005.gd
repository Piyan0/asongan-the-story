extends Node

#events start with _+number, the d, g is injected in EventArea.
func _1(d: Callable, g: GameEvent):
  ControlHint.instance.save_hint('c')
  ControlHint.instance.set_hint('c', 'RESET')
  await OverlayManager.show_overlay(
    OverlayManager.Overlay.COFFE_STAND
  )
  ControlHint.instance.set_hint('c', 'prev')
# This will be called when player leave the area, if 'trigger_by_enter is set to true.
func _1_after(d: EventUniqueData, g: GameEvent):
  pass
  
