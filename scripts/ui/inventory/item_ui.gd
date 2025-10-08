extends Control
var list: VerticalListItem
@export var show_name: bool= false
@onready var label: Label = $Label
@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
@onready var texture_rect: TextureRect = $TextureRect
@onready var control: Control = $Control
@onready var action: Label = $Control/action

var _on_nothing: Callable= func(): pass
var _on_action: Callable= func(): pass

func toggle_selection(is_on: bool):
  if is_on:
    list= VerticalListItem.new(self)
    $Control/action.set_meta('type', 'action')
    $Control/nothing.set_meta('type', 'nothing')
    list.items= [$Control/action, $Control/nothing]
    for i in list.items:
      i.modulate= Color('4e5463')
    list.index_max= 1
    list.selected_changed= func(s, a):
      for i in a:
        i.modulate= Color('4e5463')
      s.modulate= Color('ddcf99')
    list.is_active= true
    control.show()
    list.selected= func(s):
      match s.get_meta('type'):
        'nothing':
          _on_nothing.call()
        'action':
          _on_action.call()
    return
  
  if list:
    list.free()
  control.hide()

func set_action_text(t):
  #print(t)
  action.text= t
  
func set_text(t: String):
  if not show_name: return
  label.text= t

func set_texture(t: Texture2D):
  texture_rect.texture= t
  
func toggle_active(is_on: bool):
  if is_on:
    nine_patch_rect.show()
    return
  nine_patch_rect.hide()
