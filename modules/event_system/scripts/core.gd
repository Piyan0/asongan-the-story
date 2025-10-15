extends Node
class_name Event

signal interact_started()
signal interact_finished()

signal player_entered_area()
signal player_exited_area()

var last_event_run_id: String

class EventPart:
  var id: String
  var callback: Callable



var events: Array[EventPart]

@export var event_id : int
  
#TESTED = NO
func get_event(id: String) -> EventPart:
  #print(id)
  for i in events:
    if i.id== id:
      return i
      
  return null

static func get_saved_event_key() -> Dictionary:
  return GameState.events_id
  
#TESTED = NO
static func set_event(id: int, n: String) -> void:
  get_saved_event_key()[id]= n

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
    return
    
  var id= get_saved_event_key()[event_id]

  last_event_run_id= id
  if is_broadcast:
    interact_started.emit()
    
  #print(id.call())
  #print(get_saved_event_key())
  await get_event(id).callback.call()
  EventManager.instance.event_finished.emit()
  Mediator.air(Mediator.EVENT_FINISHED)
  EventManager.instance.set_can_run(true)
  
  if is_broadcast:
    interact_finished.emit.call_deferred()

func call_event(id: String, is_broadcast: bool= true):
  Mediator.air(Mediator.EVENT_STARTED)
  if is_broadcast:
    interact_started.emit()
  await get_event(id).callback.call()
  Mediator.air(Mediator.EVENT_FINISHED)
  if is_broadcast:
    interact_finished.emit.call_deferred()
