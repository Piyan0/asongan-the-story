extends Node

enum {
  PLAYER_BUBBLE_PLAYED= 0,
  PLAYER_BUBBLE_FINISHED,
  EVENT_STARTED,
  EVENT_FINISHED,
  EVENT_PLAYER_ENTERED,
  EVENT_PLAYER_EXITED,
  EQUIPPED_ITEM_USED,
  EQUIPPED_ITEM_THROWN,
  OVERLAY_HIDDEN,
  OVERLAY_SHOWNED,
  GAME_STARTED,
  GAME_PAUSED,
  GAME_RESUMED,

}

var event_mapped: Dictionary[int, Callable]= {
  PLAYER_BUBBLE_PLAYED: on_player_bubble_played,
  PLAYER_BUBBLE_FINISHED: on_player_bubble_finished,
  EVENT_STARTED: on_EventManager_event_started,
  EVENT_FINISHED: on_EventManager_event_finished,
  EVENT_PLAYER_ENTERED: on_EventManager_player_entered_area,
  EVENT_PLAYER_EXITED: on_EventManager_player_exited_area,
  EQUIPPED_ITEM_USED: on_OnHoldItemsManager_item_used,
  EQUIPPED_ITEM_THROWN: on_OnHoldItemsManager_item_thrown,
  OVERLAY_HIDDEN: on_OverlayManager_overlay_hidden,
  OVERLAY_SHOWNED: on_OverlayManager_overlay_showned,
  GAME_STARTED: on_game_started,
  GAME_PAUSED: on_game_paused,
  GAME_RESUMED: on_game_resumed,
}
  
func air(id: int, args: Array= []):
  event_mapped[id].callv(args)
  
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
  ControlHint.instance.set_hint('x', 'CLOSE')
  ControlHint.instance.set_hint('c', 'NONE')
  PlayerMovement.instance.stop(true)
  match overlay:
    OnHoldItemsManager:
      ControlHint.instance.set_hint('z', 'USE')
    InventoryManager:
      ControlHint.instance.set_hint('z', 'TOGGLE_EQUIP')
      
func on_OverlayManager_overlay_hidden(overlay):
  EventManager.instance.toggle_event_process.emit(true)
  ControlHint.instance.set_hint('z', 'prev')
  ControlHint.instance.set_hint('x', 'NONE')
  ControlHint.instance.set_hint('c', 'OPEN_SLOT')
  PlayerMovement.instance.stop(false)
  
func on_player_bubble_played():
  pass
    
func on_player_bubble_finished():
  pass

func on_EventManager_event_started():
  OverlayManager.is_can_open= false
  PlayerMovement.instance.stop(true)
  ControlHint.instance.set_hint('z', 'None')

func on_EventManager_event_finished():
  OverlayManager.is_can_open= true
  PlayerMovement.instance.stop(false)
  ControlHint.instance.set_hint('z', 'prev')
  
func on_EventManager_player_entered_area():
  ControlHint.instance.set_hint('z', 'Interact')
  ControlHint.instance.save_hint('z')

func on_EventManager_player_exited_area():
  ControlHint.instance.set_hint('z', 'None')
  ControlHint.instance.save_hint('z')
  pass

func on_game_started():
  #air(EVENT_STARTED)
  OverlayManager.is_can_open= true
  CarManager.instance.ready()
  await Transition.instance.play_transition(false)
  get_tree().change_scene_to_file("res://scenes/environment/main_road.tscn")
  OverlayManager.toggle_control_hint(true)
  await Transition.instance.play_transition(true)
  #air(EVENT_STARTED)
  
func on_game_paused():
  PlayerMovement.instance.stop(true)
  print('game paused')

func on_game_resumed():
  print('game resumed')
  PlayerMovement.instance.stop(false)
