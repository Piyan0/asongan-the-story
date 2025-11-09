extends Node2D
class_name Train
signal train_arrived()
signal train_leaved()

static var instance: Train
static var is_leaved= false
const y_can_pass: float= 1075.0
const y_end_pos: float= 1440
const y_start_pos: float= -6.0

func _ready() -> void:
  if not instance:
    instance= self

func move_train(speed: float):
  is_leaved= false
  position.y= y_start_pos
  train_arrived.emit()
  var t= create_tween()
  var duration= func(distance: float, _speed: float) -> float:
    return distance/ _speed
  t.tween_property(self, 'position:y', y_can_pass, duration.call(y_can_pass- y_start_pos, speed))
  await t.finished
  is_leaved= true
  train_leaved.emit()
  t= create_tween()
  t.tween_property(self, 'position:y', y_end_pos, duration.call(y_end_pos- y_can_pass, speed))
  
