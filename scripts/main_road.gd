extends Node2D

 
func _ready() -> void:
  Mediator.air(Mediator.TRAIN_TIMER_START, [10])
