extends Node
class_name Event

signal interact_started()
signal interact_finished()

signal player_entered_area()
signal player_exited_area()

static var __init__ = preload('../__init__.gd'):
  get:
    return __init__.resource_path.replace('__init__.gd', '')

#DEV
var VARIABLE_SAVE_PATH : String = __init__+'assets/save_data/event_variables.json'
#DEV
var KEYS_SAVE_PATH : String = __init__+'assets/save_data/event_keys.json'

var last_event_run_id: String
class EventPart:
  var id: String
  var callback: Callable

static var event_variables : Dictionary= {
  1: "Salwa",
  2: "Hawa"
}

#okay, so we might use this format for event id, like 1.2, 1 is area id, and 2 is those event id.
static var events_id : Dictionary = {
}

var events: Array[EventPart]

@export var event_id : String
@export var current_event_key : String = 'None'
  
#TESTED = NO
func get_event(id: String) -> EventPart:
  for i in events:
    if i.id== id:
      return i
      
  return null

#TESTED = NO
static func set_event(id: String, n: String) -> void:
  events_id[id]= n

#TESTED = NO
func add_event(event: EventPart) -> void:
  events.push_back(event)

#TESTED = NO
var is_can_run_event: bool= true
func _interact(is_broadcast: bool= true) -> void:
  Mediator.air(Mediator.EVENT_STARTED)
  EventManager.instance.event_started.emit()
  EventManager.instance.set_can_run(false)
  if not is_can_run_event:
    #print('noo')
    return
  if current_event_key== 'None' : return
  var id= func():
    if not event_id in events_id: 
      events_id[event_id] = current_event_key
      return current_event_key
    
    return events_id[event_id]
  
  last_event_run_id= id.call()
  if is_broadcast:
    interact_started.emit()
  await get_event(id.call()).callback.call()
  EventManager.instance.event_finished.emit()
  Mediator.air(Mediator.EVENT_FINISHED)
  EventManager.instance.set_can_run(true)
  
  if is_broadcast:
    interact_finished.emit.call_deferred()

func call_event(id: String, is_broadcast: bool= true):
  if is_broadcast:
    interact_started.emit()
  await get_event(id).callback.call()
  
  if is_broadcast:
    interact_finished.emit.call_deferred()
  
#region Event Variable

static func get_var(id : String) -> Variant:
  if not id in event_variables: return -1 
  
  return event_variables[id]

#TESTED = NO
static func set_var(id: String, new: Variant) -> void:
  event_variables[id] = new
#TESTED = NO

#TESTED = NO
static func increment_var(id: String) -> void:
  if not event_variables[id] is int: return
  
  var new_value : int = event_variables[id] + 1
  set_var(id, new_value)

#endregion
#TESTED = NO

#region Serialization
func save_variable_data() -> void:
  var file = FileAccess.open(VARIABLE_SAVE_PATH, FileAccess.WRITE)
  file.store_string(JSON.stringify(event_variables))

#TESTED = NO
func load_variable_data() -> void:
  var file = FileAccess.open(VARIABLE_SAVE_PATH, FileAccess.READ)
  var data = file.get_as_text()
  event_variables = JSON.parse_string(data)

#TESTED = NO
func save_event_keys() -> void:
  var file = FileAccess.open(KEYS_SAVE_PATH, FileAccess.WRITE)
  file.store_string(JSON.stringify(events_id))

#TESTED = NO
func load_event_keys() -> void:
  var file = FileAccess.open(KEYS_SAVE_PATH, FileAccess.READ)
  var data = file.get_as_text()
  events_id = JSON.parse_string(data)

#endregion
