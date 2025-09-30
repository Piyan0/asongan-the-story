extends CanvasLayer
signal overlay_showned(overlay)
signal overlay_hidden(overlay)

var current_overlay
var overlay

func _enter_tree() -> void:
  set_process_input(false)

func _input(event: InputEvent) -> void:
    
  if not dependency_ready():
    return
    
  if (
    event.is_action_pressed('c') 
    and OnHoldItemsManager.instance.child_instance.is_all_slots_idle() 
    and can_show(OnHoldItemsManager)
    and OnHoldItemsManager.instance.is_shown == false
    ):
    current_overlay= OnHoldItemsManager
    overlay_showned.emit(OnHoldItemsManager)
    OnHoldItemsManager.instance.toggle()
  
  if event.is_action_pressed('x'):
    close_current_overlay()
  

func toggle_inventory():
  if can_show(InventoryManager):
      current_overlay= InventoryManager
      overlay_showned.emit(InventoryManager)
      InventoryManager.instance.toggle()

func close_current_overlay():
  match current_overlay:
    InventoryManager:
      current_overlay= null
      overlay_hidden.emit(InventoryManager)
      InventoryManager.instance.toggle()
      
    OnHoldItemsManager:
      if not OnHoldItemsManager.instance.child_instance.is_all_slots_idle():
        return
      current_overlay= null
      overlay_hidden.emit(OnHoldItemsManager)
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
  
func play_transition(is_closing: bool):
  await Transition.instance.play_transition(is_closing)  
