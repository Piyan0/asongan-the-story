extends Node2D
class_name Train
signal train_arrived()
signal train_leaved()

static var instance: Train
static var leaved= false
const y_end_pos: float= 1440
const y_start_pos: float= -6.0

func _ready() -> void:
  if not instance:
    instance= self
  
  #await get_tree().create_timer(1).timeout
  #call_train(20)

func move_train(duration: float):
  position.y= y_start_pos
  train_arrived.emit()
  var t= create_tween()
  t.tween_property(self, 'position:y', y_end_pos, duration)
  await t.finished
  leaved= true
  train_leaved.emit()
