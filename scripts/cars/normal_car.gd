extends CarScene
class_name NormalCar

var car: Car
@onready var sprite: AnimatedSprite2D = $sprite
@onready var area_2d: Area2D = $Area2D
var _arrived= func(): pass
var hints:= []
var sell_areas= []
var is_buying= {
  0: false,
  1: false,
}
var reset_position: bool= true
static var sound= null

@export var variation: NormalCarVariation


func _ready() -> void:

  $Label2.text= name
  sell_areas= [
    $event, $event2
  ]
  hints= [
    $but_hint2, $but_hint
  ]
  apply_variation.call_deferred(variation)
  car= Car.new()
  car.parent_node= self
  car.moved.connect(func(_position: Vector2):

    position.y= _position.y
    Car.car_back_point[car_id]= _position- Vector2(_width(), 0)
    #print(self.position+ _position)
    sprite.stop()
    sprite.play("move")
    )
  car.stopped.connect(func():
    sprite.stop()
    await get_tree().create_timer(randf_range(0, 0.5)).timeout
    sprite.play("stop")
    )
  area_2d.area_entered.connect(func(area):
    if area.name != 'player': return
    Car.current_car= self
    )
  area_2d.area_exited.connect(func(area):
    if area.name != 'player': return
    Car.current_car= null
    )
  
  if not is_main():
    hide_hint(0)
    hide_hint(1)

@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D

func apply_variation(variation: NormalCarVariation):
  print(name)
  sell_areas[0].position= variation.sell_area_1
  sell_areas[1].position= variation.sell_area_2
  collision_shape_2d.position= variation.coll_pos
  collision_shape_2d.shape= variation.shape
  sprite.sprite_frames= variation.sprite_frames
  sprite.position= variation.sprite_pos
  hints[0].position.x= variation.sell_area_1.x
  hints[1].position.x= variation.sell_area_2.x
  $Control.size= variation.width

func is_main():
  return get_tree().current_scene== self


func match_icon(id: int, item_id: DB.Food):
  hints[id].get_child(0).get_child(1).texture= (
    load(DB.get_item(item_id).icon)
  )
  
  
func set_is_buying(id: int, cond: bool):
  is_buying[id]= cond
  
func show_hint(id: int):
  match_icon(id, sell_areas[id].event_unique_data.expected_item)    
  hints[id].show()
 

func is_buying_done() -> bool:
  return is_buying[0]== false and is_buying[1]== false


func hide_hint(id: int):
  hints[id].hide()
  

var food_request: Array[DB.Food]= []
func move_and_buy(delay: float, _position_return: Callable, sell_data: Array[SellData]):
  if not sound:
    sound= $sfx
  if not sound.playing:
    sound.play()
    
  if reset_position:
    position.x= CarScene.spawn_x_pos
    reset_position= false
  #position.y= _position_return.call().y
  
  for i in sell_data:
    GameState.food_request.push_back(i.id)
    food_request.push_back(i.id)
  
  #print(GameState.food_request)
  
  CarScene.set_moving_car(car_id, self)
  CarScene.car_delay_cache[car_id]= delay
  is_buying[0]= false
  is_buying[1]= false
  await _car_instance().move_car(delay, _position_return)
  _arrived.call()
  if sell_data.is_empty():
    return
  is_buying[sell_data[0].sell_id]= true
  sell_areas[0].event_unique_data.expected_item= sell_data[0].id
  show_hint(0)
  if sell_data.size()-1 >0:
    sell_areas[1].event_unique_data.expected_item= sell_data[1].id
    #print(sell_areas[1].event_unique_data.expected_item)
    is_buying[sell_data[1].sell_id]= true
    show_hint(1)

func get_x():
  return $event.event_unique_data.expected_item
  
func set_label(t):
  $Label.text= t
  
func _car_instance() -> Car:
  return car
  
func _width() -> float:
  return $Control.size.x
  
func _car_back_point() -> Vector2:
  return $back_point.position+ self.position
  
@onready var text_bubble: TextBubble = $TextBubble


var messages= [
  'THANKS_001',
  'THANKS_002',
  'THANKS_003',
  'THANKS_004',
  'THANKS_005',
  'THANKS_006',
]

var is_message_shown= false
func show_thanks() -> void:
  if is_message_shown: return
  is_message_shown= true
  text_bubble.set_text(messages.pick_random())
  text_bubble.show()
  await get_tree().create_timer(1).timeout
  text_bubble.hide()
  is_message_shown= false
