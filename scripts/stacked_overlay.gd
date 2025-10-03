extends Node
class_name StackedOverlay

signal overlay_changed(id: int)
class Overlay:
  var id: int
  var overlay: Control
  var overlay_tween_duration: float= 0.2
  
  func toggle_overlay(is_on: bool) -> void:
    var t= overlay.create_tween()
    var modulate= Color('#ffffff00')
    if is_on:
      overlay.show()
      overlay.modulate= modulate
      modulate= Color('#ffffff')
    
    t.tween_property(overlay, 'modulate', modulate, overlay_tween_duration)
    await t.finished
    if not is_on:
      overlay.hide()
    
var overlays: Array[Overlay]
var current_overlay: Overlay

func add_overlay(id: int, overlay_target: Node) -> void:
  var overlay: Overlay= Overlay.new()
  overlay.overlay= overlay_target
  overlay.id= id
  overlays.push_back(overlay)

func get_overlay(id: int) -> Overlay:
  if overlays.is_empty():
    return null
  
  for i in overlays:
    if i.id== id:
      return i
  
  return null

func set_current_overlay(id: int):
  current_overlay= get_overlay(id)
  
func change_overlay(id: int):
  if current_overlay:
    await current_overlay.toggle_overlay(false)
  
  var overlay: Overlay= get_overlay(id)
  #printt(current_overlay.overlay, overlay.overlay)
  current_overlay= overlay
  overlay_changed.emit(id)
  await overlay.toggle_overlay(true)
  
