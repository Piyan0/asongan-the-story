extends CanvasLayer
signal overlay_showned(overlay)
signal overlay_hidden(overlay)

var current_overlay
var overlay
var is_can_open: bool= false
var is_game_paused: bool= false

func toggle_visibility(is_on: bool):
  if is_on:
    for i in get_children():
      i.show()
      return
  else:
    for i in get_children():
      i.hide()
    
    
func _input(event: InputEvent) -> void:
    
  if not dependency_ready():
    return
  
  if event.is_action_pressed("ui_cancel"):
    if is_game_paused:
      is_game_paused= false
      Mediator.air(Mediator.GAME_RESUMED)
      #print(1)
    else:
      #print(2)
      is_game_paused= true
      Mediator.air(Mediator.GAME_PAUSED)
      
  
  if (
    event.is_action_pressed('c') 
    and OnHoldItemsManager.instance.child_instance.is_all_slots_idle() 
    and can_show(OnHoldItemsManager)
    and OnHoldItemsManager.instance.is_shown == false
    ) and is_can_open:
    current_overlay= OnHoldItemsManager
    overlay_showned.emit(OnHoldItemsManager)
    Mediator.air(Mediator.OVERLAY_SHOWNED, [OnHoldItemsManager])
    OnHoldItemsManager.instance.toggle()
  
  if event.is_action_pressed('x'):
    close_current_overlay()
  

func toggle_inventory():
  if can_show(InventoryManager):
      current_overlay= InventoryManager
      overlay_showned.emit(InventoryManager)
      Mediator.air(Mediator.OVERLAY_SHOWNED, [InventoryManager])
      InventoryManager.instance.toggle()

func close_current_overlay():
  match current_overlay:
    InventoryManager:
      current_overlay= null
      overlay_hidden.emit(InventoryManager)
      Mediator.air(Mediator.OVERLAY_HIDDEN, [InventoryManager])
      InventoryManager.instance.toggle()
      print(1)
      
    OnHoldItemsManager:
      if not OnHoldItemsManager.instance.child_instance.is_all_slots_idle():
        return
      current_overlay= null
      overlay_hidden.emit(OnHoldItemsManager)
      Mediator.air(Mediator.OVERLAY_HIDDEN, [OnHoldItemsManager])
      OnHoldItemsManager.instance.toggle()
      
func dependency_ready() -> bool:
  return ( InventoryManager.instance != null and OnHoldItemsManager.instance != null and OnHoldItemsManager.instance.child_instance!= null )
  
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
