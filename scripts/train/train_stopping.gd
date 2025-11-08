extends Node2D
class_name TrainStopping

signal car_arrived()

static var instance: TrainStopping

func _ready() -> void:
  if not instance:
    instance= self
    #
  #stop_area.area_entered.connect(func(area: Area2D):
    #if area.name!= 'car':
      #return 
    #else:
      #car_arrived.emit()
    #)
    
@onready var sprite: AnimatedSprite2D = $sprite
func toggle_lever(is_lever_down: bool):
  if is_lever_down:
    #stop_area.set_deferred('monitoring', true)
    sprite.stop()
    sprite.play("on")
  else:
    sprite.stop()
    #stop_area.set_deferred('monitoring', false)
    sprite.play('off')
  
