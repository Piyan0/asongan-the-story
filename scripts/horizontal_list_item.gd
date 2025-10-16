extends Node
class_name HorizontalListItem

var _sound_select= Sound.SFX.UI_SELECT
var _sound_accept= Sound.SFX.UI_ACCEPT
var overflowed_max: Callable= func(_items): pass
var overflowed_min: Callable= func(_items): pass

var selected_changed: Callable = func(_new, _all): pass
var selected: Callable= func(_selected): pass

var freed: Callable= func(): pass
var _can_select: Callable= func():
  return true
  
var index_active : int = -1
var items : Array[Variant]
var last_selected_child: Node
var index_max: int
var is_started_selecting: bool= false 
var is_active= false
func _init(parent) -> void:
  parent.add_child.call_deferred(self)

func release() -> void:
  freed.bind(items).call()
  
func set_index_active(add_by: int) -> void:
  if is_started_selecting:
    Sound.play(_sound_select)
  index_active+= add_by
  if index_active > index_max:
    index_active= index_max
    overflowed_max.call(items)
    return
  elif index_active < 0:
    index_active= 0
    overflowed_min.call(items)
    return
  
  last_selected_child= items[index_active]
  #print(last_selected_child, items)
  selected_changed.call(last_selected_child, items)

func get_selected() -> Node:
  return last_selected_child

func toggle_input(is_on: bool):
  is_active= is_on
  
func _input(event: InputEvent) -> void:
  if not _can_select.call() or not is_active:
    return
    
  if items.is_empty():
    return
  
  if event.is_action_pressed('ui_left'):
    is_started_selecting= true
    set_index_active(-1)
  
  elif event.is_action_pressed('ui_right'):
    is_started_selecting= true
    set_index_active(1)
  
  elif event.is_action_pressed('z') or event.is_action_pressed('ui_accept'):
    if not is_started_selecting: return
    selected.call(last_selected_child)
    Sound.play(_sound_accept)
    #print(name)
