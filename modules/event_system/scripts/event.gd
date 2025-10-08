extends Node
class_name EventArea

@onready var area_2d: Area2D = $Area2D
@export var event_unique_data: EventUniqueData
  
@export var event_id : EventsID.ID
@export var events : Script
@export var trigger_by_enter : bool= false

@export_group('Node Refs')
@export var label : Label
@export_group('')

var core : Event = Event.new()
var events_instance : Node = null

static var instances_for_debug : Array[EventArea]

func _ready() -> void:
  add_to_group('EventArea')
  core.event_id= event_id
  if events_instance== null:
    events_instance= events.new()
  
  
  #setup for event part / event member.
  for i in events.get_script_method_list():
    #print(i.name)
    var event : Event.EventPart = Event.EventPart.new()
    event.id= i.name
    event.callback= events_instance[i.name].bindv([event_unique_data, GameEvent.new()])
    core.add_event(event)
  
  setup_area()
  set_process_input(false)


var can_interact : bool = false
static var allow_interact : bool = true

func setup_area() -> void:
  if trigger_by_enter:
    area_2d.area_entered.connect(func(area):
      if area.name!= 'player': return
      await core._interact(false)
      )
    area_2d.area_exited.connect(func(area):
      if area.name!= 'player': return
      core.call_event(core.last_event_run_id+'_after', false)
      )
      
    return
  
  area_2d.area_entered.connect(func(area):
    if area.name!= 'player': return
    core.player_entered_area.emit()
    can_interact= true
    set_process_input(true)
    Mediator.air(Mediator.EVENT_PLAYER_ENTERED)
    )
    
  area_2d.area_exited.connect(func(area):
    if area.name!= 'player': return
    core.player_exited_area.emit()
    can_interact= false
    set_process_input(false)
    Mediator.air(Mediator.EVENT_PLAYER_EXITED)
    )
    
static var label_visible : bool= false

func toggle_label() -> void:
  #print(instances_for_debug)
  for i in instances_for_debug:
    if not is_instance_valid(i) : continue
    #print(i.event_id)
  
  var valid_instance : Callable= func() -> Array[EventArea]:
    var r: Array[EventArea]
    for i in instances_for_debug:
      if is_instance_valid(i):
        r.push_back(i)
    return r
  
  instances_for_debug= valid_instance.call()
  
  label_visible = !label_visible
  
  for i : EventArea in instances_for_debug:
    #print(i)
    i.label.text= str(i.event_id)
    if label_visible:
      i.label.show()
    else:
      i.label.hide()
  #

func get_event(id: String) -> Event.EventPart:
  return core.get_event(id)
  
func _input(event: InputEvent) -> void:

  #print(1)
  if trigger_by_enter: return
  #print(2)
  if not allow_interact: return
  #print(3)
  if not can_interact: return
  #print(4)
  if EventManager.instance:
    if not EventManager.instance.get_can_run(): return
  
  if (event.is_action_pressed('ui_accept')
     or event.is_action_pressed('z')
     and core.is_can_run_event
    ):
    can_interact= false
    core._interact()
    await core.interact_finished
    can_interact= true
func get_core():
  return core
