extends Node2D

var arr

func _ready() -> void:
  var arr : Array[Callable]= [
    $NormalCar.move_and_buy.bind(2*0, func(): return Vector2($Marker2D2.position.x,263), CarScene.get_template(CarScene.SellTemplate.TOFU_AND_COFFE)),
    $NormalCar2.move_and_buy.bind(2*1, Car.get_back_point.bind(Car.CarID.CAR_001), CarScene.get_template(CarScene.SellTemplate.TOFU_ONLY)),
    $NormalCar3.move_and_buy.bind(2*2, Car.get_back_point.bind(Car.CarID.CAR_002), CarScene.get_template(CarScene.SellTemplate.COFFE_ONLY))
  ]
  Mediator.air(
    Mediator.CAR_BATCH,
    [
      arr, 20, false
    ]
  )
  
