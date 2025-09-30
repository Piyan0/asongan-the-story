extends Node


func _ready() -> void:
  wire.call_deferred()
  
func wire():
  
  if Player.player:
    Player.player.bubble_played.connect(on_player_bubble_played)
    Player.player.bubble_finished.connect(on_player_bubble_played)
  if EventManager.instance:
    EventManager.instance.event_started.connect(on_EventManager_event_started)
    EventManager.instance.event_finished.connect(on_EventManager_event_finished)
    EventManager.instance.player_entered_area.connect(on_EventManager_player_entered_area)
    EventManager.instance.player_exited_area.connect(on_EventManager_player_exited_area)
  
  if OnHoldItemsManager.instance:
    OnHoldItemsManager.instance.item_used.connect(on_OnHoldItemsManager_item_used)
    OnHoldItemsManager.instance.item_thrown.connect(on_OnHoldItemsManager_item_thrown)
  
  
  OverlayManager.overlay_hidden.connect(on_OverlayManager_overlay_hidden)
  OverlayManager.overlay_showned.connect(on_OverlayManager_overlay_showned)


  
func on_OnHoldItemsManager_item_used(item: InventoryManager.Item):
  var is_item_correct: bool= InventoryManager.instance.is_used_item_correct(item.item_id)
  
  var callback_to_call: Callable= InventoryManager.instance.get_callable()
  
  if is_item_correct:
    InventoryManager.instance.delete_item(item)
    OverlayManager.stop_overlay(OnHoldItemsManager)
    OnHoldItemsManager.instance.use_current_item()
    OnHoldItemsManager.instance.toggle()
    EventManager.instance.event_started.emit()
    await callback_to_call.call()
    EventManager.instance.event_finished.emit()
    
  else:
    OverlayManager.stop_overlay(OnHoldItemsManager)
    Player.player.play_bubble('no_interact')
    OnHoldItemsManager.instance.toggle()
 
func on_OnHoldItemsManager_item_thrown(item: InventoryManager.Item):
  InventoryManager.instance.delete_item(item)
  OverlayManager.stop_overlay(OnHoldItemsManager)
  OnHoldItemsManager.instance.use_current_item()
  OnHoldItemsManager.instance.toggle()
  EventManager.instance.event_started.emit()
  await ThrowItem.instance.throw(load(item.icon))
  EventManager.instance.event_finished.emit()
  
    
func on_OverlayManager_overlay_showned(overlay):
  EventManager.instance.toggle_event_process.emit(false)
  ControlHint.instance.set_hint('x', 'Close')
  ControlHint.instance.set_hint('c', 'None')
  PlayerMovement.instance.stop(true)
  match overlay:
    OnHoldItemsManager:
      ControlHint.instance.set_hint('z', 'Use')
    InventoryManager:
      ControlHint.instance.set_hint('z', 'Equip/unequip')
      
  
func on_OverlayManager_overlay_hidden(overlay):
  EventManager.instance.toggle_event_process.emit(true)
  ControlHint.instance.set_hint('z', 'prev')
  ControlHint.instance.set_hint('x', 'None')
  ControlHint.instance.set_hint('c', 'Open Slot')
  PlayerMovement.instance.stop(false)
  
func on_player_bubble_played():
  pass
    
func on_player_bubble_finished():
  pass

func on_EventManager_event_started():
  PlayerMovement.instance.stop(true)
  ControlHint.instance.set_hint('z', 'None')

func on_EventManager_event_finished():
  PlayerMovement.instance.stop(false)
  ControlHint.instance.set_hint('z', 'prev')
  
func on_EventManager_player_entered_area():
  ControlHint.instance.set_hint('z', 'Interact')
  ControlHint.instance.save_hint('z')

func on_EventManager_player_exited_area():
  ControlHint.instance.set_hint('z', 'None')
  ControlHint.instance.save_hint('z')
  pass
