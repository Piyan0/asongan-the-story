extends Node2D

 
func _ready() -> void:
  await get_tree().create_timer(1).timeout
  await MainRoadManager.instance.prepare_for_train()
  await MainRoadManager.instance.prepare_for_train()
  await MainRoadManager.instance.prepare_for_train()
  await MainRoadManager.instance.prepare_for_train()
