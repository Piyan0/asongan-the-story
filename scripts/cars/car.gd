extends Node
class_name Car
signal stopped()
signal moved()
signal arrived()
var parent_node: Node2D
var is_moving: bool= false
var tween: Tween
const base_speed: float= 90



  
func move_car(_position: Vector2, is_broadcast: bool= false):


  tween= parent_node.create_tween()
  moved.emit()
  is_moving= true
  tween.tween_property(parent_node, 'position', _position, get_time(base_speed, _position))
  await tween.finished
  if is_broadcast:
    arrived.emit()

func get_time(speed: float, move_pos: Vector2) -> float:
  var distance: float= parent_node.position.distance_to(move_pos)
  return float(distance/ speed)
  
func stop():
  if tween:
    tween.pause()
  stopped.emit()

func continue_move():
  
  moved.emit()
  tween.play()
