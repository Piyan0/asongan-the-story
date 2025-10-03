extends Node
class_name OptionsSelection

signal option_changed(option: Options, direction: String)
signal option_ready(initial_tittle: String)
class Options:
  var tittle: String
  var callback: Callable

var current_index: int= 0
var is_active: bool= false
var options: Array[Options]

func initial_index(index: int):
  current_index= index
  
func add_options(option: Options):
  options.push_back(option)

func initial_option():
  option_ready.emit(options[current_index])
 
func change_options(add_by: , direction: String):
  var index_max: int= options.size()-1
  var index_min: int= 0
  
  current_index+= add_by
  if current_index>= index_max:
    current_index= index_max
  elif current_index<= index_min:
    current_index= index_min
  
  option_changed.emit(
    options[current_index], direction
  )

func _input(e: InputEvent) -> void:
  if not is_active:
    return
    
  if e.is_action_pressed('ui_left'):
    change_options(-1, 'left')
  elif e.is_action_pressed('ui_right'):
    change_options(1, 'right')
