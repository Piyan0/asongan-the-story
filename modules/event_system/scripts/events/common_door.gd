extends Node

func _1(d, g: GameEvent):
  await g.change_scene(load(d.scene), OverlayManager.get_tree(), d.spawn_position)
  #print(1)
