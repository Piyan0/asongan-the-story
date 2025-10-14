extends Node2D
class_name MouseCircular

var _on_moved= func(_is_clockwise: bool): pass
var origin: Vector2
var last_vector: Vector2
var is_clockwise= false

func _init(_origin: Vector2, parent: Node):
  origin= _origin
  parent.add_child.call_deferred(self)
  
func _ready() -> void:
  last_vector= get_global_mouse_position()
  
func _input(event: InputEvent) -> void:
  if event is InputEventMouseMotion:
    var current_vect= event.position- origin
    current_vect= current_vect.normalized()
    
    is_clockwise= last_vector.cross(current_vect) > 0
    _on_moved.call(is_clockwise)
    last_vector= current_vect
    
