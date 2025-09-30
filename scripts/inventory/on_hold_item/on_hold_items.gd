extends Control
class_name OnHoldItems

func _ready():
  add_to_group('OnHoldItems')

func get_items() -> Array[ItemSlot]:
  return [
    $HBoxContainer/item, $HBoxContainer/item2, $HBoxContainer/item3, $HBoxContainer/item4, $HBoxContainer/item5, $HBoxContainer/item6, $HBoxContainer/item7
  ]

func is_all_slots_idle() -> bool:
  for i in get_items():
    if i.get_is_tweening():
      return false
  
  return true
  
