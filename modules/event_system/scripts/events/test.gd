extends Node


func _1(d, g):
  OverlayManager.toggle_inventory()
  await OverlayManager.overlay_hidden
  
func _2(d, g):
  #print(1)
  OnHoldItemsManager.instance.set_use_mode(true)
  
func _2_after(d, g):
  #print(2)
  OnHoldItemsManager.instance.set_use_mode(false)
