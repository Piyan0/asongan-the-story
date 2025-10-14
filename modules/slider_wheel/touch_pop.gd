extends Node

var is_idle: bool= true
var target: Control

const scale_down= Vector2(0.9, 0.9)
const scale_up= Vector2(1.1, 1.1)

func offset_center():
  target.pivot_offset= Vector2(target.size) / 2
  
func pop() -> void:
  if not is_idle:
    print('busy.')
    return
  offset_center()
  is_idle= false
  var t= target.create_tween()
  t.tween_property(target, 'scale', scale_down, 0.1)
  t.chain().tween_property(target, 'scale', scale_up, 0.1)
  t.chain().tween_property(target, 'scale', Vector2(1,1), 0.1)
  await t.finished
  is_idle= true
