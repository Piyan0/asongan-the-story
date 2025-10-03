extends Node
class_name GameTemplate

signal paused()
signal resumed()

signal started()
signal gone_to_tittle_screen()

var is_paused: bool= false
func _ready():
  started.connect(_on_game_started)

func _on_game_started():
  pass
  
func _input(event: InputEvent):

  if event.is_action_pressed('ui_cancel'):
    if is_paused:
      is_paused= true
      paused.emit()
      
    else:
      is_paused= false
      resumed.emit()
      
    
