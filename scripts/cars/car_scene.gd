extends Node2D
class_name CarScene
signal car_lined()

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

static var row_1: float= 263
static var row_2: float= 354
static var spawn_x_pos: float= -86.0
static var car_delay_cache: ={
  
}
static var car_moving_callback: Array[Callable]
static var moving_cars: Dictionary[int, CarScene]
static var vanish_point: float= 1400

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
   

static func add_car_moving(callable: Callable):
  car_moving_callback.push_back(callable)
  
  
static func move_based_on_callable():
  current_car_arrived= 0
  var on_car_arrived= func(max):
    current_car_arrived+= 1
    if current_car_arrived>= max:
      print('all cars moved.')
      GameState.car_lined.emit()
      
  for i in car_moving_callback:
    i.call()
    await Mediator.get_tree().process_frame
  
  var total_cars: int= moving_cars.size()
  for i in moving_cars:
    moving_cars[i]._arrived= on_car_arrived.bind(total_cars)
    
  
static func reset_moving_cars() -> void:
  moving_cars= {}
 
static var current_car_arrived: int


static func move_to_vanish_point():
  current_car_arrived= 0
  var on_car_arrived= func(max):
    current_car_arrived+= 1
    if current_car_arrived>= max:
      for i in moving_cars:
        moving_cars[i].reset_position= true
      moving_cars= {}
      car_moving_callback= []
      print('all cars moved.')
      GameState.car_lined.emit()
    
  var total_cars: int= moving_cars.size()
  for i in moving_cars:
    var car: CarScene= moving_cars[i]
    car._arrived= on_car_arrived.bind(total_cars)
    car.hide_hint(0)
    car.hide_hint(1)
    car.is_buying[0]= false
    car.is_buying[1]= false
    var empty_buy: Array[SellData]= []
    car.move_and_buy(get_cached_delay(car.car_id), func(): return Vector2(vanish_point, car.position.y), empty_buy)
  

static func get_cached_delay(id: Car.CarID):
  return car_delay_cache[id]


func _car_instance() -> Car:
  return null
  
func _width() -> float:
  return 0.0

func _car_back_point() -> Vector2:
  return Vector2.ZERO
