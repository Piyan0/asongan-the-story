extends Control

signal closed()
@export var show_time: int= 2
@onready var label: Label = $Label

var is_showing_alert: bool= false
func alert(t: String, is_auto_hide= true):
  if is_showing_alert:
    return
  is_showing_alert= true
  label.show()
  label.text= t
  if is_auto_hide:
    await get_tree().create_timer(show_time).timeout
  else:
    await closed
  label.hide()
  is_showing_alert= false

func close():
  closed.emit()
