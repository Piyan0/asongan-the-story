extends Node
class_name GameEvent

func set_item_status(item_id_correct: String, callback: Callable):
  InventoryManager.instance.set_callable(callback)
  InventoryManager.instance.set_item_id_correct(item_id_correct)
func reset_item_status():
  InventoryManager.instance.reset_item_status()
func add_coin(value: int):
  Player.player.display_coin(value)

func change_scene(scene: PackedScene, tree: SceneTree):
  await Transition.instance.play_transition(false)
  tree.change_scene_to_packed(scene)
  await tree.process_frame
  await Transition.instance.play_transition(true)
  
  
