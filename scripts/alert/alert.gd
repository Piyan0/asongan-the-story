extends Control

@export var show_time: int= 2
@onready var label: Label = $Label

var is_showing_alert: bool= false
func alert(t: String):
  if is_showing_alert:
    return
  is_showing_alert= true
  label.show()
  label.text= t
  await get_tree().create_timer(show_time).timeout
  label.hide()
  is_showing_alert= false
