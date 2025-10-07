extends Node
class_name EventManager

signal event_started()
signal event_finished()

signal player_entered_area()
signal player_exited_area()

signal toggle_event_process(is_can_run: bool)
class Autostart:
  var event_area_id : int
  var event_key_id : String
  
  static func properties() -> Array[String]:
    return ['event_area_id', 'event_key_id']
  
var is_can_run_event: bool= true
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

func get_instance_by_id(id: int) -> EventArea:
  print(id)
  for i : EventArea in get_tree().get_nodes_in_group('EventArea'):
    if i.event_id== id:
      return i
  
  return null

func execute_autostart() -> void:
  var autostart_called : Array[Autostart]
  for i in queue_autostart:
    var event_area: EventArea= get_instance_by_id(i.event_area_id)
    if event_area != null:
      event_started.emit()
      Mediator.air(Mediator.EVENT_STARTED)
      await event_area.get_event(i.event_key_id).callback.call()
      autostart_called.push_back(i)
      event_finished.emit()
      Mediator.air(Mediator.EVENT_FINISHED)
  
  for i in autostart_called:
    queue_autostart.erase(i)
  
func add_autostart(event_area_id: int,event_key_id: String):
  var auto : Autostart = Autostart.new()
  auto.event_area_id= event_area_id
  auto.event_key_id= event_key_id
  queue_autostart.push_back(auto)
    
