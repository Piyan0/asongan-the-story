extends Label
class_name MenuLabel

@export var is_set_text_on_ready= true
func _ready() -> void:

  if not is_set_text_on_ready: return
  set_text(text)
  
func toggle_indicator(is_on: bool):
  var modulate_active= Color('4b3d44')
  var modulate_inactive= Color('645355')
  if is_on:
    $NinePatchRect.show()
    self.self_modulate= modulate_active
    return
  $NinePatchRect.hide()
  self.self_modulate= modulate_inactive

func get_label() -> Label:
  return self
