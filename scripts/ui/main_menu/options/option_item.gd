extends Control
class_name OptionItem

@export var tittle: String

func _ready() -> void:
  $menu_item.set_text(tittle)
func toggle_indicator(is_on: bool):
  #print(is_on)
  $menu_item.toggle_indicator(is_on)
  
@onready var ui_changeable_value: Control = $ui_changeable_value

func set_text(t, direction: String):
  ui_changeable_value.set_text(t)
  if direction=='left':
    ui_changeable_value.pointer_giggle(true)
  elif direction=='right':
    ui_changeable_value.pointer_giggle(false)
  
func get_tittle_label() -> Label:
  return $menu_item.get_label()
    
func get_value_label() -> Label:
  return $ui_changeable_value.get_label()
