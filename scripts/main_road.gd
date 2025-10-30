extends Node2D
class_name MainRoad


class CarBatchData:
  var car: Car.CarID
  var buy: Array[DB.Food]
  var delay: float
  var destination: Car.CarID
  
  
var row_1_stop = Vector2(841, CarScene.row_1)
var row_2_stop = Vector2(841, CarScene.row_2)


const car = Car.CarID
const templ = CarScene.SellTemplate
static var i: MainRoad
func _ready() -> void:
  GameState.on_initial_scene_loaded(func():
    Managers.get_event_manager().call_event_from_instance(EventsID.ID.MAIN_ROAD_AUTO, '_2')
    )
  if not i:
    i = self
    
  limit_player()

  
func limit_player():
  $player_limit.area_entered.connect(func(area):
    if area.name != 'player': return
    Player.player.position=Vector2(960, 150)
    OverlayManager.show_alert('PLAYER_LIMIT')
    )


# DEPENDENT cars_node
func get_cars() -> Array[CarScene]:
  return [
    $car001, $car002, $car003, $car004, $car005, $car006, $car007, $car008, $car009, $car010, $car011, $car012, $car013, $car014, $car015, $car016
  ]


func get_cars_by_id(id: Car.CarID) -> CarScene:
  for i in get_cars():
    if i.car_id == id:
      return i
      
  return
  

func move_cars_from_dict(data: Array) -> Array[Callable]:
  var batches: Array[CarBatchData]
  for i in data:
    var batch := CarBatchData.new()
    batch.car = i.car_type
    batch.delay = i.delay
    batch.destination = i.destination
    var buy: Array[DB.Food]
    buy.assign(i.buy)
    batch.buy = buy
    batches.push_back(batch)
  
  var r: Array[Callable]
  for i in batches:
    var cb = move_car(i.car, i.destination, i.buy, i.delay)
    r.push_back(cb)
  return r
  


func move_car(id: Car.CarID, position_id: int, buy: Array[DB.Food], delay: float, ) -> Callable:
  var car: CarScene = get_cars_by_id(id)
  var position_callable: Callable
  if position_id == -1:
    position_callable = func():
      return row_1_stop
  elif position_id == -2:
    position_callable = func():
      return row_2_stop
  else:
    position_callable = Car.get_back_point.bind(position_id)
  
  #print(position_callable.call())
  var sell_data: Array[CarScene.SellData]
  var current_id = 0
  for i in buy:
    var sell := CarScene.SellData.new()
    sell.id = i
    sell.sell_id = current_id
    sell_data.push_back(sell)
    
  return car.move_and_buy.bind(delay, position_callable, sell_data)
