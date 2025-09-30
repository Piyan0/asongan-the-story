extends Node
class_name TrainManager

var instance: TrainManager

func _ready() -> void:
  if not instance:
    instance= self
