extends Node2D
class_name CarScene

class SellData:
  var id: DB.Food
  var sell_id: int

enum SellTemplate{
  TOFU_ONLY,
  TOFU_AND_EXTRA,
  TOFU_AND_COFFE,
  TOFU_WITH_RICE_ROLL_ONLY,
  COFFE_ONLY,
}

static var car_delay_cache: ={
  
}

static var moving_cars: Dictionary[int, CarScene]

@export var car_id: Car.CarID

static func get_template(id: SellTemplate) -> Array[SellData]:
  match id:
    SellTemplate.TOFU_ONLY:
      var sell_001 := SellData.new()
      sell_001.sell_id= 0
      sell_001.id= DB.Food.PACK_OF_TOFU
      return [sell_001]
      
    SellTemplate.TOFU_AND_EXTRA:
      var sell_001 := SellData.new()
      sell_001.sell_id= 0
      sell_001.id= DB.Food.PACK_OF_TOFU
      var sell_002 := SellData.new()
      sell_002.sell_id= 1
      sell_002.id= DB.Food.TOFU_WITH_RICE_ROLL
      return [sell_001, sell_002]
      
    SellTemplate.TOFU_AND_COFFE:
      var sell_001 := SellData.new()
      sell_001.sell_id= 0
      sell_001.id= DB.Food.PACK_OF_TOFU
      var sell_002 := SellData.new()
      sell_002.sell_id= 1
      sell_002.id= DB.Food.COFFE
      return [sell_001, sell_002]
      
    SellTemplate.TOFU_WITH_RICE_ROLL_ONLY:
      var sell_002 := SellData.new()
      sell_002.sell_id= 0
      sell_002.id= DB.Food.TOFU_WITH_RICE_ROLL
      return [sell_002]
      
    SellTemplate.COFFE_ONLY:
      var sell_002 := SellData.new()
      sell_002.sell_id= 0
      sell_002.id= DB.Food.COFFE
      return [sell_002]
    
  return []
  

static func set_moving_car(id: int, car: CarScene):
  moving_cars[id]= car
   
  
static func reset_moving_cars() -> void:
  moving_cars= {}
 
 
static func get_cached_delay(id: Car.CarID):
  return car_delay_cache[id]


func _car_instance() -> Car:
  return null
  
func _width() -> float:
  return 0.0

func _car_back_point() -> Vector2:
  return Vector2.ZERO
