extends Node
class_name TopdownMovement

signal direction_changed(direction, last_direction)

var direction: Vector2
var last_direction: Vector2
var body: CharacterBody2D
var move_speed: int= 2000
var is_stopped: bool= false

func physics_process(delta: float) -> void:
  if is_stopped:
    return 
    
  direction.x= Input.get_axis('ui_left', 'ui_right')
  direction.y= Input.get_axis('ui_up', 'ui_down')
  
  body.velocity= direction* (move_speed)
  body.move_and_slide()
    
  if is_direction_changed():
    direction_changed.emit(direction, last_direction)
  
  last_direction= direction

func toggle_stop(is_on: bool):
  is_stopped= is_on
  if not is_on:
    #KUNAI_OFF
    #printt(direction, last_direction)
    direction_changed.emit(direction, last_direction)
  
func is_direction_changed()-> bool:
  return direction!= last_direction
