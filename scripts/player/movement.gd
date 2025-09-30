extends Node
class_name PlayerMovement

@onready var player: Player = $".."
@onready var sprite: AnimatedSprite2D = $"../sprite"

var current_idle_animation: String
var topdown_movement: TopdownMovement
var last_x_axis: float

static var instance: PlayerMovement

func _ready() -> void:
  if not instance:
    instance= self
  topdown_movement = TopdownMovement.new()
  topdown_movement.body= player
  topdown_movement.move_speed= 4500
  topdown_movement.direction_changed.connect(on_direction_changed)

func stop(is_stop: bool):
  topdown_movement.stop= is_stop
  sprite.play(current_idle_animation)
  
func on_direction_changed(new_direction: Vector2, previous_direction: Vector2):
  #printt(new_direction, previous_direction)
  match new_direction:
    
    Vector2.ZERO:
      match previous_direction:
        Vector2.LEFT, Vector2(-1, -1):
          sprite.play('idle_left')
        Vector2.RIGHT, Vector2(1, -1):
          sprite.play('idle_right')
        Vector2.DOWN, Vector2(1, 1),Vector2(-1, 1):
          sprite.play('idle_down')
        Vector2.UP:
          match last_x_axis:
            1.0:
              sprite.play('idle_right')
            -1.0:
              sprite.play('idle_left')      
    
    Vector2.LEFT, Vector2(-1, -1) ,Vector2(-1, 1):
      if last_x_axis == 1.0:
        topdown_movement.stop= true
        sprite.play("idle_down")
        await sprite.animation_finished
        topdown_movement.stop= false
      sprite.play('walk_left')
      current_idle_animation= 'idle_left'
  
    Vector2.RIGHT, Vector2(1, -1) , Vector2(1, 1):
      if last_x_axis == -1.0:
        topdown_movement.stop= true
        sprite.play("idle_down")
        await sprite.animation_finished
        topdown_movement.stop= false
      sprite.play('walk_right')
      current_idle_animation= 'idle_right'

    Vector2.DOWN:
      sprite.play("walk_down")
      current_idle_animation= 'idle_down'
      
    Vector2.UP:
      match last_x_axis:
        1.0:
          sprite.play('walk_right')
          current_idle_animation= 'idle_right'
        -1.0:
          current_idle_animation= 'idle_left'
          sprite.play('walk_left')
        _:
          current_idle_animation= 'idle_left'
          sprite.play('walk_left')
          
  set_last_axis(new_direction.x)
  
func set_last_axis(axis: float):
  if axis!= 0:
    last_x_axis= axis
    
func _process(delta: float) -> void:
  topdown_movement._process(delta)

  
