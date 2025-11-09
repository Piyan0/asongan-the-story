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

const FADE_DUR= 0.4
const FADE_DELAY= 0.4
func fade_in():
  var t= create_tween()
  t.tween_property(
    $ColorRect, 'self_modulate', Color('ffffff'), FADE_DUR
  )
  await t.finished
  
func fade_out():
  await get_tree().create_timer(FADE_DELAY).timeout
  var t= create_tween()
  t.tween_property(
    $ColorRect, 'self_modulate', Color('ffffff00'), FADE_DUR
  )
  await t.finished
  
