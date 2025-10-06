extends TextureRect
class_name Ingredient

var pop= TouchPop.new()
@onready var button: Button = $Button
@onready var pointer: TextureRect = $pointer
var _clicked = func(id: int): pass

var is_idle: bool= true

func _ready() -> void:
  pointer.hide()
  
  pop.target= self
  button.button_down.connect(func():
    if not is_idle: return
    is_idle= false
    _clicked.call()
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
  last_count= count
  label.text= str(count)
  last_count= count

func decrement_count():
  last_count-= 1
  set_count(last_count)
  
