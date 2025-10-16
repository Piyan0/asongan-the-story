extends Node2D

var arr

func _ready() -> void:
  
  var sell_data_test= CarScene.SellData.new()
  sell_data_test.id= DB.Food.TOFU_WITH_RICE_ROLL
  sell_data_test.sell_id=0
  
  var sell_data_test_2= CarScene.SellData.new()
  sell_data_test_2.id= DB.Food.PACK_OF_TOFU
  sell_data_test_2.sell_id=1
  
  var sell_data_test_3= CarScene.SellData.new()
  sell_data_test_3.id= DB.Food.COFFE
  sell_data_test_3.sell_id=1
  
  var test: Array[CarScene.SellData]= [
    sell_data_test,
    sell_data_test_2
  ]
  var test_2: Array[CarScene.SellData]= [sell_data_test, sell_data_test_3]

 
  CarScene.add_car_moving($NormalCar.move_and_buy.bind(2*0, func(): return Vector2($Marker2D2.position.x,263), CarScene.get_template(CarScene.SellTemplate.TOFU_AND_COFFE)))
  CarScene.add_car_moving($NormalCar2.move_and_buy.bind(2*1, Car.get_back_point.bind(Car.CarID.CAR_001), CarScene.get_template(CarScene.SellTemplate.TOFU_ONLY)),)  
  CarScene.add_car_moving($NormalCar3.move_and_buy.bind(2*2, Car.get_back_point.bind(Car.CarID.CAR_002), CarScene.get_template(CarScene.SellTemplate.COFFE_ONLY)),)
  
  CarScene.move_based_on_callable()
 

  await get_tree().create_timer(8).timeout
  CarScene.move_to_vanish_point()
  
