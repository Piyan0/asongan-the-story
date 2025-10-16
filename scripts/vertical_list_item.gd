extends Node
class_name VerticalListItem

var _sound_select= Sound.SFX.UI_SELECT
var _sound_accept= Sound.SFX.UI_ACCEPT
var overflowed_max: Callable= func(items): pass
var overflowed_min: Callable= func(items): pass

var selected_changed: Callable = func(new, all): pass
var selected: Callable= func(s): pass

var freed: Callable= func(): pass
var _can_select: Callable= func():
  return true
  
var index_active : int = -1
var items : Array
var last_selected_child: Node
var index_max: int
var is_started_selecting: bool= false 
var is_active= false

func _init(parent) -> void:
  parent.add_child.call_deferred(self)

func release() -> void:
  freed.bind(items).call()
  
func set_index_active(add_by: int) -> void:
  Sound.play(_sound_select)
  var is_overflowed_max: bool= false
  var is_overflowed_min: bool= false
  index_active+= add_by
  if index_active > index_max:
    is_overflowed_max= true
    index_active= index_max
    #overflowed_max.call(items)
    #return
  elif index_active < 0:
    is_overflowed_min= true
    index_active= 0
    #overflowed_min.call(items)
    #return
  
  #print(last_selected_child, items)
  if last_selected_child == items[index_active]:
    pass
  else:
    last_selected_child= items[index_active]
    selected_changed.call(last_selected_child, items)
  if is_overflowed_max:
    overflowed_max.call(items)
  elif is_overflowed_min:
    overflowed_min.call(items)

func get_selected() -> Node:
  return last_selected_child

func toggle_input(is_on: bool):
  is_active= is_on
 
 
func reset():
  index_active=0
  last_selected_child= items[0]
  
  
func _input(event: InputEvent) -> void:
  if not _can_select.call() or not is_active:
    return
    
  if items.is_empty():
    return
  
  if event.is_action_pressed('ui_up'):
    is_started_selecting= true
    set_index_active(-1)
  
  elif event.is_action_pressed('ui_down'):
    is_started_selecting= true
    set_index_active(1)
  
  elif event.is_action_pressed('z') or event.is_action_pressed('ui_accept'):
    if not is_started_selecting: return
    Sound.play(_sound_accept)
    selected.call(last_selected_child)
    #print(name)
