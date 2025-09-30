extends Control
class_name ThrowItem

static var instance: ThrowItem

@onready var texture_rect: TextureRect = $TextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
  if not instance:
    instance= self
    
func throw(icon: Texture2D):
  texture_rect.show()
  texture_rect.texture= icon
  animation_player.play('throw')
  await animation_player.animation_finished
  texture_rect.hide()
  
