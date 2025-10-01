extends Node
class_name EventManager

signal event_started()
signal event_finished()

signal player_entered_area()
signal player_exited_area()

signal toggle_event_process(is_can_run: bool)
class Autostart:
  var event_area_id : String
  var event_key_id : String
  
  static func properties() -> Array[String]:
    return ['event_area_id', 'event_key_id']
  
var is_can_run_event: bool= true
var debug_list : Array[EventDebugLabel]
var container : VBoxContainer
#SAVE
var queue_autostart : Array[Autostart]
static var core_instance : Array[Event]
static var instance: EventManager
static var wire_queue: Array[Callable]
#var is_can_run_event: bool= true
func _ready() -> void:
  container= VBoxContainer.new()
  container.add_theme_constant_override('separation',0)
  self.add_child(container) 
  if instance== null:
    instance = self
    for i in wire_queue:
      i.call()
    wire_queue= []
  else:
    self.queue_free()

func set_can_run(can_run: bool):
  is_can_run_event= can_run
func get_can_run():
  return is_can_run_event
  
static func add_instance(event: Event):
  if instance== null:
    wire_queue.push_back(add_instance.bind(event))
    return
    
  
  instance.toggle_event_process.connect(func(can_run: bool):
    event.is_can_run_event= can_run
    )
    
  event.interact_started.connect(func():
    instance.event_started.emit()
    EventManager.instance.set_can_run(false)
    )
  event.interact_finished.connect(func():
    instance.event_finished.emit()
    EventManager.instance.set_can_run(true)
    )
  
  event.player_entered_area.connect(func():
    instance.player_entered_area.emit()
    )
  
  event.player_exited_area.connect(func():
    instance.player_exited_area.emit()
    )
    
func get_instance_by_id(id: String) -> EventArea:
  for i : EventArea in get_tree().get_nodes_in_group('EventArea'):
    if i.event_id== id:
      return i
  
  return null
  
func get_event_label(id: String) -> EventDebugLabel:
  for i in debug_list:
    
    if i.name== id:
      return i
    
  return null
  
func add_debug(text: String, callback: Callable= func(): pass) -> void:
  var event_label : EventDebugLabel = EventDebugLabel.new().get_self()
  debug_list.push_back(event_label)
  event_label.set_text('? ' +text)
  event_label.set_call(callback)
  
  event_label.label_clicked.connect(delete_debug_label)
  container.add_child(event_label)
  
func delete_debug_label(id: String) -> void:
  var event_debug : EventDebugLabel = get_event_label(id)
  if event_debug:
    debug_list.erase(event_debug)
    event_debug.queue_free()

func execute_autostart() -> void:
  var autostart_called : Array[Autostart]
  for i in queue_autostart:
    var event_area: EventArea= get_instance_by_id(i.event_area_id)
    if event_area != null:
      event_started.emit()
      await event_area.get_event(i.event_key_id).callback.call()
      autostart_called.push_back(i)
      event_finished.emit()
  
  for i in autostart_called:
    queue_autostart.erase(i)
  
func add_autostart(event_area_id: String,event_key_id: String):
  var auto : Autostart = Autostart.new()
  auto.event_area_id= event_area_id
  auto.event_key_id= event_key_id
  queue_autostart.push_back(auto)
    
