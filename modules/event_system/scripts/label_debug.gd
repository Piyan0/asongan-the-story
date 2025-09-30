extends Label
class_name EventDebugLabel
signal label_clicked(this_name: String)

var callback : Callable
var scene_path : String = Event.__init__+'scenes/label_debug.tscn'

@export var button : Button

func _ready() -> void:
  button.mouse_entered.connect(active.bind(true))
  button.mouse_exited.connect(active.bind(false))
  button.button_down.connect(click)

func click() -> void:
  label_clicked.emit(self.name)
  if callback:
    await callback.call()

func set_call(call: Callable):
  callback= call
  
func active(cond: bool) -> void:
  var color_in : Color= Color('757575')
  var color_out: Color= Color('ffffff')
  
  if cond:
    self.self_modulate= color_in
  else:
    self.self_modulate= color_out

func get_self() -> EventDebugLabel:
  return load(scene_path).instantiate()
