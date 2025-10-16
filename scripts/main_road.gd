extends Node2D

func _ready() -> void:
  
  limit_player()
  
  var arr : Array[Callable]= [
    $NormalCar.move_and_buy.bind(2*0, func(): return Vector2($train_stop.position.x,263), CarScene.get_template(CarScene.SellTemplate.TOFU_AND_COFFE)),
    $NormalCar2.move_and_buy.bind(2*1, Car.get_back_point.bind(Car.CarID.CAR_001), CarScene.get_template(CarScene.SellTemplate.TOFU_ONLY)),
    $NormalCar9.move_and_buy.bind(0, func(): return Vector2($train_stop.position.x, CarScene.row_2), CarScene.get_template(CarScene.SellTemplate.COFFE_ONLY))
  ]
  Mediator.air(
    Mediator.CAR_BATCH,
    [
      arr, 5
    ]
  )
  
func limit_player():
  $player_limit.area_entered.connect(func(area):
    if area.name != 'player': return
    Player.player.position= Vector2(960, 150)
    OverlayManager.show_alert('PLAYER_LIMIT')
    )
