extends Node
class_name TopdownMovement

signal direction_changed(direction, last_direction)

var direction: Vector2
var last_direction: Vector2
var direction_before_stopped: Vector2
var body: CharacterBody2D
var move_speed: int= 2000
var stop: bool= false

func _process(delta):
  if stop:
    #last_direction= Vector2.ZERO
    return 
    
  direction.x= Input.get_axis('ui_left', 'ui_right')
  direction.y= Input.get_axis('ui_up', 'ui_down')
  
  body.velocity= direction* move_speed* delta
  body.move_and_slide()
  
  if direction!=Vector2.ZERO:
    direction_before_stopped= direction
    
  if is_direction_changed():
    #print(1)
    direction_changed.emit(direction, last_direction)
  
  last_direction= direction
  
func is_direction_changed()-> bool:
  return direction!= last_direction
