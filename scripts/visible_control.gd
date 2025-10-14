extends Node
class_name VisibleControl

@export var nodes : Array[Node]
@export var id : GameState.Visible

func _ready() -> void:
  show(
    GameState.visible_state[id]
  )
  
func add_pos(pos_to_add: Vector2) -> void:
  for i in nodes:
    i.position += pos_to_add

func show(cond:bool) -> void:
  for i in nodes:
    i.visible = cond
  
  GameState.set_visible(id, cond)
