extends Node
class_name WaitForSecond


static var instance : WaitForSecond

func _ready() -> void:
  if not instance:
    instance= self
func wait(duration: float):
  await get_tree().create_timer(duration).timeout
