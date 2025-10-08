extends Node2D

 
func _ready() -> void:
  #TranslationServer.set_locale('id')
  Mediator.air(Mediator.TRAIN_TIMER_START, [20])
