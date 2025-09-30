extends CanvasLayer
class_name ControlHint

@onready var label: Label = $Label
@onready var container: VBoxContainer = $container
static var instance: ControlHint

#SAVE
var data: Dictionary= {
  'z': 'None',
  'x': 'None',
  'c': 'Open slot'
}

#SAVE
var prev_data: Dictionary= {
  'z': 'None',
  'x': 'None',
  'c': 'Open slot'
}

func _ready() -> void:
  if not instance:
    instance= self
    
  _update()
func _update():
  for i in container.get_children():
    i.free()
  
  for i in data:
    var text= '[%s] %s' % [i, data[i]]
    var _label= label.duplicate()
    _label.show()
    _label.text= text
    container.add_child(_label)

func save_hint(id: String):
  prev_data[id]= data[id]
  
func set_hint(id: String, action: String):
  data[id]= action
  if action== 'prev':
    data[id]= prev_data[id]
  _update()

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("ui_accept"):
    set_hint('z', 'Select item')
  
