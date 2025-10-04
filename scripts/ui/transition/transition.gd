extends CanvasLayer
class_name Transition

static var instance: Transition

func _ready() -> void:
  if not instance:
    instance= self
  
    
@onready var sprite_2d: ColorRect = $Sprite2D
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

func play_transition(is_close: bool):
  sprite_2d.show()
  if is_close:
    sprite_2d.rotation_degrees= 180
    animation_player.play_backwards("new_animation")
  else:
    
    animation_player.play("new_animation")
    sprite_2d.rotation_degrees=0
  
  await animation_player.animation_finished
  if is_close:
    sprite_2d.hide()
