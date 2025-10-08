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
  SETTINGS_CHANGED,
  MAIN_MENU_LOADED,
  
  TRAIN_TIMER_START,
  TRAIN_TIMER_TOGGLE,
  TRAIN_TIMER_FINISHED,
  
  INVENTORY_ITEM_USED,
  INVENTORY_ITEM_DROPPED,
  
  SHOP_ITEM_BUYED,
  
  CURRENT_COIN,
  
  SCENE_CHANGED,

}

var event_mapped: Dictionary[int, Callable]= {
  PLAYER_BUBBLE_PLAYED: on_player_bubble_played,
  PLAYER_BUBBLE_FINISHED: on_player_bubble_finished,
  EVENT_STARTED: on_EventManager_event_started,
  EVENT_FINISHED: on_EventManager_event_finished,
  EVENT_PLAYER_ENTERED: on_EventManager_player_entered_area,
  EVENT_PLAYER_EXITED: on_EventManager_player_exited_area,
  #EQUIPPED_ITEM_USED: on_OnHoldItemsManager_item_used,
  #EQUIPPED_ITEM_THROWN: on_OnHoldItemsManager_item_thrown,
  OVERLAY_HIDDEN: on_OverlayManager_overlay_hidden,
  OVERLAY_SHOWNED: on_OverlayManager_overlay_showned,
  GAME_STARTED: on_game_started,
  GAME_PAUSED: on_game_paused,
  GAME_RESUMED: on_game_resumed,
  MAIN_MENU_LOADED: on_main_menu_loaded,
  
  INVENTORY_ITEM_USED: on_shop_item_buyed,
  INVENTORY_ITEM_DROPPED: on_inventory_item_used,
  SHOP_ITEM_BUYED: on_inventory_item_dropped,
  
  CURRENT_COIN: current_coin,
  SETTINGS_CHANGED: on_settings_changed,
  
  TRAIN_TIMER_FINISHED: on_train_timer_finished,
  TRAIN_TIMER_START: set_train_arrival,
  TRAIN_TIMER_TOGGLE: on_train_timer_toggle,
  
  SCENE_CHANGED: on_scene_changed,
}
  
func air(id: int, args: Array= []):
  event_mapped[id].callv(args)

func on_scene_changed():
  print('scene is changed.')
  Managers.get_event_manager().execute_autostart.call_deferred()
 
func add_autostart(id: int, key_id: String):
   Managers.get_event_manager().add_autostart(id, key_id)
  
func on_train_timer_finished():
  if get_tree().current_scene.name!= 'MainRoad':
    add_autostart(EventsID.ID.MAIN_ROAD_005, '_1')
    print('finished outside road.')
  else:
    print('call train!')

func on_train_timer_toggle(is_on: bool):
  if train_timer:
    train_timer.paused= not is_on
    
var train_timer: Timer

func set_train_arrival(seconds: int):
  train_timer= Timer.new()
  add_child(train_timer)
  var time_left= seconds
  for i in seconds:
    var minute:int= time_left/ 60
    var second= time_left % 60
    OverlayManager.get_hud().set_train_arrival(minute, second)
    train_timer.start(1)
    await train_timer.timeout
    time_left-= 1
  OverlayManager.get_hud().set_train_arrival(0, 0)
  train_timer.queue_free()
  on_train_timer_finished()
  
func on_main_menu_loaded() -> void:
  Saveable.load_from_file()
  if Saveable.has_key('settings'):
    GameOptions.new().apply_settings(
      Saveable.get_data('settings')
    )
  
  if Saveable.has_key('settings_index'):
    var settings_index: Dictionary= Saveable.string_keys_to_int(
        Saveable.get_data('settings_index')
      )
    OptionsSelectionMenu.saved_setting_index= settings_index
    #print( OptionsSelectionMenu.saved_setting_index )
    #print(settings_index)
 
func on_settings_changed(settings: Dictionary):
  Saveable.set_data('settings', settings)
  Saveable.set_data('settings_index', OptionsSelectionMenu.saved_setting_index)
  Saveable.save_to_file()
  
func current_coin() -> int:
  return 400
  
#func on_OnHoldItemsManager_item_used(item: InventoryManager.Item):
  #var is_item_correct: bool= InventoryManager.instance.is_used_item_correct(item.item_id)
  #
  #var callback_to_call: Callable= InventoryManager.instance.get_callable()
  #
  #if is_item_correct:
    #InventoryManager.instance.delete_item(item)
    #OverlayManager.stop_overlay(OnHoldItemsManager)
    #OnHoldItemsManager.instance.use_current_item()
    #OnHoldItemsManager.instance.toggle()
    #EventManager.instance.event_started.emit()
    #await callback_to_call.call()
    #EventManager.instance.event_finished.emit()
    #
  #else:
    #OverlayManager.stop_overlay(OnHoldItemsManager)
    #Player.player.play_bubble('no_interact')
    #OnHoldItemsManager.instance.toggle()
 #
#func on_OnHoldItemsManager_item_thrown(item: InventoryManager.Item):
  #InventoryManager.instance.delete_item(item)
  #OverlayManager.stop_overlay(OnHoldItemsManager)
  #OnHoldItemsManager.instance.use_current_item()
  #OnHoldItemsManager.instance.toggle()
  #EventManager.instance.event_started.emit()
  #await ThrowItem.instance.throw(load(item.icon))
  #EventManager.instance.event_finished.emit()
    #
func on_OverlayManager_overlay_showned(overlay):
  EventManager.instance.toggle_event_process.emit(false)
  ControlHint.instance.set_hint('x', 'CLOSE')
  ControlHint.instance.set_hint('c', 'NONE')
  PlayerMovement.instance.stop(true)
  #match overlay:
    #OnHoldItemsManager:
      #ControlHint.instance.set_hint('z', 'USE')
    #InventoryManager:
      #ControlHint.instance.set_hint('z', 'TOGGLE_EQUIP')
      #
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
  ControlHint.instance.set_hint('z', 'NONE')

func on_EventManager_event_finished():
  OverlayManager.is_can_open= true
  PlayerMovement.instance.stop(false)
  ControlHint.instance.set_hint('z', 'prev')
  
func on_EventManager_player_entered_area():
  ControlHint.instance.set_hint('z', 'Interact')
  ControlHint.instance.save_hint('z')

func on_EventManager_player_exited_area():
  ControlHint.instance.set_hint('z', 'NONE')
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

func on_shop_item_buyed(item: Shop.ShopItem) -> void:
  pass

func on_inventory_item_used(item: Inventory.Item) -> void:
  pass

func on_inventory_item_dropped(item: Inventory.Item) -> void:
  pass
