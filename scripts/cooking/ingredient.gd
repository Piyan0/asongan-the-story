extends TextureRect
class_name Ingredient

signal ingredient_used(id: String, instance: Ingredient)
var pop= TouchPop.new()
@onready var button: Button = $Button
@onready var pointer: TextureRect = $pointer

var is_idle: bool= true
@export var id: String

func _ready() -> void:
  pointer.hide()
  
  pop.target= self
  button.button_down.connect(func():
    if not is_idle: return
    ingredient_used.emit(id, self)
    is_idle= false
    await pop.pop()
    is_idle= true
    )
  
  button.mouse_entered.connect(func():
    pointer.show()
    )
  button.mouse_exited.connect(func():
    pointer.hide()
    )
@onready var label: Label = $TextureRect/Label

var last_count: int
func set_count(count: int):
  label.text= str(count)
  last_count= count

func decrement_count():
  last_count-= 1
  set_count(last_count)
  
