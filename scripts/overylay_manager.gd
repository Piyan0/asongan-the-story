extends CanvasLayer
signal overlay_showned(overlay)
signal overlay_hidden(overlay)

var current_overlay
var overlay
var is_can_open: bool= false
var is_game_paused: bool= false

func _ready():
  pass
  #print(tr('OPEN_SLOT'))
func toggle_visibility(is_on: bool):
  if is_on:
    for i in get_children():
      i.show()
      return
  else:
    for i in get_children():
      i.hide()
  
func can_show(clas):
  if current_overlay== null:
    return true
  if current_overlay== clas:
    return true
  return false

func stop_overlay(overlay):
  current_overlay= null
  overlay_hidden.emit(overlay)
  Mediator.air(Mediator.OVERLAY_HIDDEN, [overlay])
  
func play_transition(is_closing: bool):
  await Transition.instance.play_transition(is_closing)  

func toggle_control_hint(is_on: bool):
  $CanvasLayer.visible= is_on
@onready var alert: Control = $Alert

func show_alert(t: String, is_auto_hide: bool= true):
  alert.alert(t, is_auto_hide)
  
func get_alert():
  return alert

func get_hud():
  return $hud
