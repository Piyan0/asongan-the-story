extends Node

func _1(d, g: GameEvent):
  g.open_inventory()
  await OverlayManager.overlay_hidden
