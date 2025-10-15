extends Node2D

var arr
var x= 1
func _ready() -> void:
  var y= test.bind(get_)
  x= 2
  y.call()
  arr= [
      $NormalCar._car_instance().move_car.bind(0, func(): return Vector2($Marker2D2.position.x,263) ),
      $NormalCar2._car_instance().move_car.bind(2, Car.get_back_point.bind(Car.CarID.CAR_001)),
      $NormalCar3._car_instance().move_car.bind(7, Car.get_back_point.bind(Car.CarID.CAR_002))
  ]
  for i in arr:
    i.call()

func test(x):
  print(x.call())

func get_():
  return x
