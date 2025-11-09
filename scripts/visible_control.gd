extends Node
class_name VisibleControl

@export var nodes : Array[Node]
@export var id : GameState.Visible

func _ready() -> void:
  add_to_group('VisibleGroup')
  set_state(
    GameState.visible_state[id]
  )
  
func add_pos(pos_to_add: Vector2) -> void:
  for i in nodes:
    i.position += pos_to_add

func set_state(cond:bool) -> void:
  for i in nodes:
    i.visible = cond
  
  GameState.set_visible(id, cond)

static func set_state_by_id(id: GameState.Visible, state: bool) -> void:
  for i in Mediator.get_tree().get_nodes_in_group('VisibleGroup'):
    if i.id== id:
      i.set_state(state)
  
static func get_first_member(id: GameState.Visible) -> Node2D:
  for i in Mediator.get_tree().get_nodes_in_group('VisibleGroup'):
    if i.id== id:
      return i.nodes[0]
  
  return null
  
