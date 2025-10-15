extends CarScene

var car: Car
@onready var sprite: AnimatedSprite2D = $sprite
@onready var area_2d: Area2D = $Area2D

var hints:= []
var is_buying= {
  0: true,
  1: true,
}
func _ready() -> void:
  hints= [
    $but_hint, $but_hint2
  ]
  car= Car.new()
  car.parent_node= self
  car.moved.connect(func():
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


func set_is_buying(id: int, cond: bool):
  is_buying[id]= cond
  
func show_hint(id: int):
  hints[id].show()
 

func hide_hint(id: int):
  hints[id].hide()
  
  
func set_label(t):
  $Label.text= t
  
func _car_instance() -> Car:
  return car
  
func _width() -> float:
  return $Control.size.x
  
func _car_back_point() -> Vector2:
  return $back_point.position+ self.position
