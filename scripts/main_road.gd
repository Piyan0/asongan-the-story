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

var sign_hint: ProcessWatch

func _ready() -> void:
  var x= C_001.new()
  x.fn()
  #GameState.on_initial_scene_loaded(func():
    #Managers.get_event_manager().call_event_from_instance(EventsID.ID.MAIN_ROAD_AUTO, '_2')
    #)
  if not i:
    i = self
    
  limit_player()
  sign_hint= ProcessWatch.new()
  sign_hint.callb= func():
    print('hinted.')
    toggle_sign_hint(true)
    #GameState.is_buyer_fulfilled= false


func _process(delta: float) -> void:
  sign_hint.tick([GameState.is_buyer_fulfilled, Train.leaved])
  
func limit_player():
  $player_limit.area_entered.connect(func(area):
    if area.name != 'player': return
    Player.player.position=Vector2(960, 150)
    OverlayManager.show_alert('PLAYER_LIMIT')
    )


# DEPENDENT cars_node
func get_cars() -> Array[CarScene]:
  var cars: Array[CarScene]
  cars.assign($cars.get_children())
  return cars


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


func toggle_train_blockade(is_on: bool) -> void:
  $StaticBody2D/train_blockade.set_deferred('disabled', not is_on)


func toggle_bazzard_blockade(is_on: bool) -> void:
  $StaticBody2D/blockade.set_deferred('disabled', not is_on)
  VisibleControl.set_state_by_id(
    GameState.Visible.MAIN_ROAD__BAZARD_BLOCKADE, false
  )

func move_from_beyond_area() -> void:
  var beyond_rect: Rect2= Rect2(
    $beyond_area.position,
    $beyond_area.size
  )
  var in_beyond_area: bool= Player.player.get_rect().intersects(beyond_rect)
  if in_beyond_area:
    Player.player.position=Vector2(960, 150)
  
  
func toggle_sign_hint(is_on: bool) -> void:
  var _sign_hint= $sign_hint
  if is_on:
    _sign_hint.show()
    _sign_hint.find_child('AnimationPlayer').play('idle')
  else:
    _sign_hint.hide()
    print('hiding.')
    _sign_hint.find_child('AnimationPlayer').stop()

func set_train_sign_status(is_green: bool) -> void:
  var sign: Sprite2D= $MainRoadArt.get_sign()
  var green= preload('res://assets/sprites/environment/map/main_road/train_sign_green.png')
  var red= preload('res://assets/sprites/environment/map/main_road/train_sign_red.png')
  if is_green:
    sign.texture= green
  else:
    sign.texture= red

func set_camera_pos(pos: Vector2) -> void:
  $Camera2D.position= pos

func toggle_camera(state: bool) -> void:
  $Camera2D.enabled= state

func tween_camera(to_pos: Vector2, dur= 1.0) -> void:
  var t= create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
  t.tween_property(
    $Camera2D, 'position', to_pos, dur
  )
  await t.finished
