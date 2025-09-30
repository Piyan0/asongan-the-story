extends CarScene

var car: Car
@onready var sprite: AnimatedSprite2D = $sprite

func _ready() -> void:
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

func set_label(t):
  $Label.text= t
  
func _car_instance() -> Car:
  return car
  
func _width() -> float:
  return $Control.size.x
