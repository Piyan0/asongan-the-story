extends Control

@onready var left: TextureRect = $Label/left
@onready var right: TextureRect = $Label/right

var left_giggle: float
var right_giggle: float
var left_default: float
var right_default: float

var giggle_value: float= 3
func _ready() -> void:
  right_default= right.position.x
  left_default= left.position.x
  
  left_giggle= left_default- giggle_value
  right_giggle= right_default+ giggle_value

func set_text(t: String):
  $Label.text= t
  
func pointer_giggle(is_left: bool):
  if is_left:
    left.position.x= left_default
    var t= create_tween()
    t.tween_property(left, 'position:x', left_giggle, 0.1)
    t.chain().tween_property(left, 'position:x', left_default, 0.1)
    return
    
  right.position.x= right_default
  var t= create_tween()
  t.tween_property(right, 'position:x', right_giggle, 0.1)
  t.chain().tween_property(right, 'position:x', right_default, 0.1)
    
func get_label() -> Label:
  return $Label
    
    
