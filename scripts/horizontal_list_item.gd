extends Node
class_name HorizontalListItem


var selected_changed: Callable = func(): pass
var freed: Callable= func(): pass
var _can_select: Callable= func():
  return true
  
var index_active : int = -1
var items : Array
var last_selected_child: Node
var index_max: int
var is_started_selecting: bool= false 

func _init(parent) -> void:
  parent.add_child.call_deferred(self)

func release() -> void:
  freed.bind(items).call()
  
func set_index_active(add_by: int) -> void:
  index_active+= add_by
  if index_active > index_max:
    index_active= index_max
  elif index_active < 0:
    index_active= 0
  
  last_selected_child= items[index_active]
  selected_changed.unbind(2)
  selected_changed.bind(last_selected_child, items).call()

func get_selected() -> Node:
  return last_selected_child

func _input(event: InputEvent) -> void:
  if not _can_select.call():
    return
    
  if items.is_empty():
    return
  if event.is_action_pressed('ui_left'):
    is_started_selecting= true
    set_index_active(-1)
  
  elif event.is_action_pressed('ui_right'):
    is_started_selecting= true
    set_index_active(1)
