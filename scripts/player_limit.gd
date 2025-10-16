extends Area2D
class_name PlayerLimit

static var instance: PlayerLimit

func _ready() -> void:
  if not instance:
    instance= self
  
  toggle(false)
  
  
func toggle(is_active: bool):
  if is_active:
    position.x= 1253
  else:
    position.x= 1330
