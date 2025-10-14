extends Control
class_name ShopItemUI

var is_idle: bool= true
var is_state_active: bool= false
@onready var icon: TextureRect = $info_container/NinePatchRect/icon
@onready var info_container: Control = %info_container
@onready var status: Label = %status
@onready var _name: Label = %name
@onready var pointer: TextureRect = $pointer
@onready var cost: Label = %cost


func set_item_name(t: String):
  _name.text= t

func set_cost(_cost: String):
  cost.text= 'RP.'+_cost
  
func set_status(_stock: String, _owned: String):
  status.text= 'stock x{stock} owned x{owned}'.format({
    'stock': _stock,
    'owned': _owned
  })
  
func toggle_active(is_on: bool):
  const x_position_add_by := 10
  const dur := 0.1
  var t := create_tween()
  var position_start: float= info_container.position.x
  var position_final: float
  
  is_idle= false
  
  if is_on:
    
    pointer.show()
    position_final= position_start+ x_position_add_by
  else:
    pointer.hide()
    position_final= position_start- x_position_add_by
  

  t.tween_property(info_container, 'position:x', position_final, dur)
  await t.finished
  is_idle= true
  
  if is_on:
    is_state_active= true
  else:
    is_state_active= false


func set_icon(_icon: Texture2D) -> void:
  icon.texture= _icon
