extends Node
class_name CarManager

signal cars_arrived_at_vanishing_point()
signal cars_stopped()
signal cars_leaved()
class Row:
  var max_car_at_row: int
  var y_pos: float
  var x_pos: float
  var current_x_pos: float
  var cars: Array[CarScene]
  var distance_min_max= Vector2(40, 120)
  signal car_arrived()
  
  func is_cars_idle():
    return cars.is_empty()
    
  func toggle_move(is_move: bool):
  
    for i in cars:
      if is_move:
        i._car_instance().continue_move()
      else:  
        i._car_instance().stop()
    
  func on_car_arrived(car: CarScene):
    cars.erase(car)
    car_arrived.emit()
    CarManager.instance.available_cars.push_back(car)

      
  func batch():
    current_x_pos= x_pos
    for i in max_car_at_row:
      
      var car= CarManager.instance.get_random_car()
      car.set_label(str(y_pos))
      #randomize()
      var random_distance_add= randf_range(distance_min_max.x, distance_min_max.y)
      #print(random_distance_add)
      current_x_pos-= car._width()+ random_distance_add
      car.position= Vector2(current_x_pos, y_pos)
      #car.position.x-= car._width()
      cars.push_back(car)
      
        
      var arrived_signal= car._car_instance().arrived
      for j in arrived_signal.get_connections():
        arrived_signal.disconnect(j.callable)
      
      arrived_signal.connect(on_car_arrived.bind(car))
        
      car._car_instance().move_car(Vector2(CarManager.instance.vanishing_x_point, y_pos) , true)
      
      

static var instance: CarManager
var cars_available: Array

var cars_scene_path: Array[String] =[
  "res://scenes/cars/normal_car.tscn"
]
@export var test: int
var car_cache_size: int= 24

var available_cars: Array[CarScene]
var active_cars: Array[CarScene]

var vanishing_x_point: float= 1400
var rows: Array[Row]

var cars_on_road: Array[CarScene]


func _ready() -> void:
  if not instance:
    #print(1)
    instance= self
  
func ready() -> void:
  var row_1= Row.new()
  row_1.max_car_at_row= 2
  row_1.y_pos= 263
  row_1.x_pos= -50
  
  var row_2= Row.new()
  row_2.max_car_at_row= 3
  row_2.y_pos= 354
  row_2.x_pos= -50
  
  row_1.car_arrived.connect(on_car_arrived)
  row_2.car_arrived.connect(on_car_arrived)
  
  rows.push_back(row_1)
  rows.push_back(row_2)
  cache_cars()
   

func is_all_car_arrived() -> bool:
  for i in rows:
    if not i.is_cars_idle(): return false
  return true

func on_car_arrived():
  if is_all_car_arrived():
    cars_leaved.emit()
      
func cache_cars() -> void:
  for i in cars_scene_path:
    for j in car_cache_size:
      var ins: CarScene = load(i).instantiate()
      available_cars.push_back(ins) 
      get_tree().current_scene.add_child.call_deferred(ins)

func batch_cars():
  for i in rows:
    i.batch()
    
func toggle_move(is_move: bool):
  for i in rows:
    i.toggle_move(is_move)
  
  if not is_move:
    cars_stopped.emit()
    
func get_random_car():
  if available_cars.is_empty():
    #print(1)
    pass
  var car: CarScene
  car= available_cars.pick_random()
  available_cars.erase(car)
  return car
