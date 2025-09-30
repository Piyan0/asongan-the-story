extends CharacterBody2D

const MOVE_SPEED :int = 3000
const NOT_WALK : int = -1
const WALK_LEFT : int = 1
const WALK_UP : int = 2
const WALK_RIGHT : int = 3
const WALK_DOWN : int = 4
const WALK_TOP_LEFT : int = 5
const WALK_TOP_RIGHT : int = 6
const WALK_DOWN_LEFT : int = 7
const WALK_DOWN_RIGHT : int = 8

var last_direction : float = -1.0

var last_x_direction : float = 1.0
var is_direction_down : bool = false
var is_direction_left : bool = false
var is_direction_right : bool = false
var has_moved : bool = false
func _process(delta: float) -> void:
 
  var x_axis : float = Input.get_axis('ui_left', 'ui_right')
  var y_axis : float = Input.get_axis('ui_up', 'ui_down')
  
  var direction : Vector2 = Vector2(x_axis, y_axis)

  var walk_direction : int = get_walk_direction(direction)
  
  var is_moving : bool = direction != Vector2.ZERO
  
  if is_moving:
    has_moved = true
    velocity= direction * MOVE_SPEED * delta
    if direction.y == 1.0:
      is_direction_down = true
    else:
      is_direction_down= false
    move_and_slide()
  
  elif has_moved:
    walk_direction= NOT_WALK
    play_stop_anim(last_x_direction)
  
  
  if last_direction != walk_direction:
    play_walk_anim(walk_direction)
    

  if direction.x != 0.0:
    last_x_direction= direction.x
    
  if direction.x == 1.0:
    is_direction_right= true
    is_direction_left= false
    
  elif direction.x == -1.0 :
    is_direction_right= false
    is_direction_left= true
    
  last_direction= walk_direction

@export var sprite : AnimatedSprite2D

func play_walk_anim(walk_direction: int) -> void:
  var anim_to_play : String
  match walk_direction:
    WALK_UP:
      if last_x_direction== -1:
        anim_to_play= 'walk_left'
        last_x_direction= -1.0
      else:
        anim_to_play= 'walk_right'
        last_x_direction= 1.0
        
    WALK_DOWN:
      anim_to_play= 'walk_down'
    WALK_LEFT, WALK_TOP_LEFT, WALK_DOWN_LEFT:
      if not is_direction_left: 
        set_process(false)
        sprite.play('idle_down')
        await sprite.animation_finished
        sprite.stop()
        set_process(true)
      anim_to_play = 'walk_left'
     
    WALK_RIGHT, WALK_TOP_RIGHT, WALK_DOWN_RIGHT:
      if not is_direction_right: 
        set_process(false)
        sprite.play('idle_down')
        await sprite.animation_finished
        sprite.stop()
        set_process(true)
      anim_to_play= 'walk_right'
    
  sprite.play(anim_to_play)

func play_stop_anim(x_direction : float) -> void:

  var anim_to_play : String
  
  if is_direction_down:
    sprite.play('idle_down')
    return
    
  match x_direction:
    1.0:
      anim_to_play= 'idle_right'
    -1.0:
      anim_to_play= 'idle_left'
    0.0:
      anim_to_play= 'idle_down'
      
  sprite.play(anim_to_play)
    
      
func get_walk_direction(direction: Vector2) -> int:
  match direction:
    Vector2(-1, 0):
      return WALK_LEFT
    Vector2(0, -1):
      return WALK_UP
    Vector2(1, 0):
      return WALK_RIGHT
    Vector2(0, 1):
      return WALK_DOWN
    Vector2(-1, -1):
      return WALK_TOP_LEFT
    Vector2(1, -1):
      return WALK_TOP_RIGHT
    Vector2(-1, 1):
      return WALK_DOWN_LEFT
    Vector2(1, 1):
      return WALK_DOWN_RIGHT
      
  return -1
