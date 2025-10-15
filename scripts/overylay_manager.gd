extends CanvasLayer
signal overlay_showned(overlay)
signal overlay_hidden(overlay)
signal lmb_clicked()

enum Overlay {
  IDLE,
  INVENTORY,
  SHOP,
  TOFU_STAND,
  COFFE_STAND,
  PAUSE,
  
}
var current_overlay: Overlay= Overlay.IDLE
var overlays

var is_can_open: bool= false
var is_game_paused: bool= false

func _ready():
  
  get_hud().set_money(GameState.current_coin)
  get_hud().set_train_arrival(99, 99)
  
  overlays= {
    Overlay.INVENTORY: {
      target= $Inventory,
      show_method= $Inventory.display_inventory,
      close_method= $Inventory.close,
      can_close= func(): return true
    },
    
    Overlay.SHOP: {
      target= $Shop,
      show_method= $Shop.display_items,
      close_method= $Shop.close,  
      can_close= func(): return true  
    },
    
    Overlay.TOFU_STAND: {
      target= $TofuStand,
      show_method= $TofuStand.prepare,
      close_method= $TofuStand.close, 
      can_close= $TofuStand.get_can_close,   
    },
    Overlay.COFFE_STAND: {
      target= $CoffeStand,
      show_method= $CoffeStand.prepare,
      close_method= $CoffeStand.close,
      can_close= $CoffeStand.get_can_close,
    },
    Overlay.PAUSE: {
      target= $GamePause,
      show_method= $GamePause.initiate,
      close_method= $GamePause.close,
      can_close= func(): return true
    },
  }
  
  hide_overlays()

func hide_overlays():
  for i in overlays:
    overlays[i].target.hide()
    
func toggle_visibility(is_on: bool):
  if is_on:
    for i in get_children():
      i.show()
      return
  else:
    for i in get_children():
      i.hide()
  
func can_show(_overlay: Overlay):
  if current_overlay== Overlay.IDLE:
    return true
  if current_overlay== _overlay:
    return true
  return false

func show_overlay(id: Overlay) -> void:

  var overlay= overlays[id]
  overlay_showned.emit()
  overlay.target.show()
  overlay.show_method.call()
  current_overlay= id
  Mediator.air(Mediator.OVERLAY_SHOWNED, [id])
  await overlay_hidden
  
func stop_overlay(id: Overlay):
  var overlay= overlays[id]
  if not overlay.can_close.call():
    return
  overlay.target.hide()
  overlay.close_method.call()
  current_overlay= Overlay.IDLE
  Mediator.air(Mediator.OVERLAY_HIDDEN, [id])
  overlay_hidden.emit()

func stop_current_overlay():
  if current_overlay== Overlay.IDLE:
    return
  stop_overlay(current_overlay)
  
func play_transition(is_closing: bool):
  await Transition.instance.play_transition(is_closing)  

func toggle_control_hint(is_on: bool):
  $CanvasLayer.visible= is_on
  
@onready var alert: Control = $Alert
func show_alert(t: String, is_auto_hide: bool= true):
  alert.alert(t, is_auto_hide)
  if not is_auto_hide:
    await lmb_clicked
  
func get_alert():
  return alert

func get_hud():
  return $hud

func _input(event: InputEvent) -> void:
  if event.is_action_pressed('x'):
    stop_current_overlay()
    
  if event.is_action_pressed("left_click"):
    lmb_clicked.emit()
  
  if event.is_action_pressed("c") and current_overlay== Overlay.IDLE:
    print_debug(1)
    Mediator.air(Mediator.GAME_PAUSED)
