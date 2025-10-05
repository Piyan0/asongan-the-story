extends CanvasLayer
class_name ControlHint


@onready var container: HBoxContainer = $container
static var instance: ControlHint

#SAVE
var data: Dictionary= {
  'z': 'NONE',
  'x': 'NONE',
  'c': 'OPEN_SLOT'
}

#SAVE
var prev_data: Dictionary= {
  'z': 'NONE',
  'x': 'NONE',
  'c': 'OPEN_SLOT'
}

func _ready() -> void:
  if not instance:
    instance= self
    
  _update()
  Input.joy_connection_changed.connect(func(device, connected: bool):
    toggle_controller_mode(connected)
    )

  
func _update():
  $container/z/Label.text= data['z']
  $container/x/Label.text= data['x']
  $container/c/Label.text= data['c']

func toggle_controller_mode(is_using_controller: bool):
  if is_using_controller:
    $container/z/TextureRect.texture= load('res://assets/sprites/ui/buttons/button_a.png')
    $container/x/TextureRect.texture= load('res://assets/sprites/ui/buttons/button_b.png')
    $container/c/TextureRect.texture= load('res://assets/sprites/ui/buttons/button_x.png')
    return
    
  $container/z/TextureRect.texture= load('res://assets/sprites/ui/buttons/button_z.png')
  $container/x/TextureRect.texture= load('res://assets/sprites/ui/buttons/button_x.png')
  $container/c/TextureRect.texture= load('res://assets/sprites/ui/buttons/button_c.png')
  
  
  
func save_hint(id: String):
  prev_data[id]= data[id]
  
func set_hint(id: String, action: String):
  data[id]= action
  if action== 'prev':
    data[id]= prev_data[id]
  _update()
