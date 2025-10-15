extends Node2D
class_name CarScene

@export var car_id: Car.CarID

func _car_instance() -> Car:
  return null
  
func _width() -> float:
  return 0.0

func _car_back_point() -> Vector2:
  return Vector2.ZERO
