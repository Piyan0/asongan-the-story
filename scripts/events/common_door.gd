extends Node

func _1(d: Callable, g: GameEvent):
  await g.change_scene(load(d.call().scene), OverlayManager.get_tree(), d.call().spawn_position)

func _2(d, g):
  pass
