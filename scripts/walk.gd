extends Node
class_name Walk

var targ: Node2D
var speed: float= 60.0

func set_targ(_targ: Node2D) -> void:
  targ= _targ

func set_speed(_speed: float) -> void:
  speed= _speed

func jump(height= 5.0) -> void:
  var t= targ.create_tween().set_trans(Tween.TRANS_CIRC)
  var y= targ.position.y- height
  t.tween_property(
    targ, 'position:y', y, 0.2
  )
  await t.finished
  t= targ.create_tween()
  t.tween_property(
    targ, 'position:y', targ.position.y+height , 0.1
  )
  await t.finished
  
func walk(to: String, callb: Callable= Callable()) -> void:
  var x: float
  var y: float
  if to.contains('x'):
    x= float( to.split(':')[1] )
    y= targ.position.y
  elif to.contains('y'):
    x= targ.position.x
    y= float( to.split(':')[1] )
  else:
    x= float( to.split(',')[0] )
    x= float( to.split(',')[1] )
  
  if not callb.is_null():
    callb.call()
  
  var duration= func() -> float:
    return targ.position.distance_to(Vector2(x, y)) / speed
    
  var t= targ.create_tween()
  t.tween_property(
    targ, 'position', Vector2(x, y), duration.call()
  )
  await t.finished
  
  
    
