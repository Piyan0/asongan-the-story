extends Control
class_name TextBubble

@onready var label: Label = $Label

@export var id: EventsID.ID
static var group='TextBubble'
func _ready() -> void:
  add_to_group(group)
  if is_main():
    await get_tree().process_frame
    show_text(EventsID.ID.MAIN_ROAD_001, 'Salwaaa.')
  else:
    hide()
  
  
func set_text(t: String):
  label.text= t
  
  
func is_main() -> bool:
  return get_tree().current_scene== self


static func show_text(id: int, t: String, duration= 2):
  var bubble: TextBubble
  for i in Mediator.get_tree().get_nodes_in_group(group):
    if i.id== id:
      bubble= i
  
  bubble.show()
  bubble.set_text(t)
  await Mediator.get_tree().create_timer(duration).timeout
  #bubble.free()
  if bubble:
    bubble.hide()
