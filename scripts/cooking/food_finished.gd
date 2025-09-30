extends Control

@onready var icon: Sprite2D = $Coffe
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var button: Button = $Button

var is_idle: bool= false
func _ready() -> void:
  button.button_down.connect(on_button_down)
  
func on_button_down() -> void:
  if not is_idle: return
  print('food_taken')
  
func set_icon(_icon: Texture2D) -> void:
  icon.texture= _icon
  await get_tree().process_frame
  animation_player.play("new_animation")
  await animation_player.animation_finished
  is_idle= true

@onready var ending_anim: AnimationPlayer = $enidng_rect/ending_anim

func close():
  ending_anim.play("new_animation")
  await ending_anim.animation_finished
  
