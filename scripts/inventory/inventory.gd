extends Control
class_name Inventory

func _ready() -> void:
  add_to_group('Inventory')
  
func get_item_slot() -> Array[InventoryItem]:
  return [
    $Control/Control/HBoxContainer/ColorRect, $Control/Control/HBoxContainer/ColorRect2, $Control/Control/HBoxContainer/ColorRect3, $Control/Control/HBoxContainer/ColorRect4, $Control/Control/HBoxContainer/ColorRect5, $Control/Control/HBoxContainer/ColorRect6, $Control/Control/HBoxContainer/ColorRect7, $Control/Control/HBoxContainer/ColorRect8, $Control/Control/HBoxContainer/ColorRect9, $Control/Control/HBoxContainer/ColorRect10
  ]
@onready var status_label: Label = $Control/ColorRect/HBoxContainer/status_label

func update_status(current, max) -> void:
  status_label.text= 'equipped %d/%d' % [current, max]
