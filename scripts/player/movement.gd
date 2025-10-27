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
  topdown_movement.move_speed= 72
  topdown_movement.direction_changed.connect(on_direction_changed)

func stop(is_stop: bool):
  topdown_movement.toggle_stop(is_stop)
  if is_stop:
    sprite.play(current_idle_animation)
  
func on_direction_changed(new_direction: Vector2, previous_direction: Vector2):
  #print(9)
  match new_direction:
    
    Vector2.ZERO:
      sprite.play(current_idle_animation)
      #match previous_direction:
        #Vector2.LEFT, Vector2(-1, -1):
          #sprite.play('idle_left')
        #Vector2.RIGHT, Vector2(1, -1):
          #sprite.play('idle_right')
        #Vector2.DOWN, Vector2(1, 1),Vector2(-1, 1):
          #sprite.play('idle_down')
        #Vector2.UP:
          #match last_x_axis:
            #1.0:
              #sprite.play('idle_right')
            #-1.0:
              #sprite.play('idle_left')      
    
    Vector2.LEFT, Vector2(-1, -1) ,Vector2(-1, 1):
      if last_x_axis == 1.0:
        topdown_movement.is_stopped= true
        sprite.play("idle_down")
        await sprite.animation_finished
        topdown_movement.is_stopped= false
      sprite.play('walk_left')
      current_idle_animation= 'idle_left'
  
    Vector2.RIGHT, Vector2(1, -1) , Vector2(1, 1):
      if last_x_axis == -1.0:
        topdown_movement.is_stopped= true
        sprite.play("idle_down")
        await sprite.animation_finished
        topdown_movement.is_stopped= false
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
          #printt('no dirr', current_idle_animation)
          sprite.play('walk_left')
          
  set_last_axis(new_direction.x)
  
func set_last_axis(axis: float):
  if axis!= 0:
    last_x_axis= axis
    
func _physics_process(delta: float) -> void:
  #print(delta)
  topdown_movement.physics_process(delta)
  #print(topdown_movement.is_stopped)

  
