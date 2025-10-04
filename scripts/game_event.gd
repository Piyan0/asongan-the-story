extends Node
class_name GameEvent

func set_item_status(item_id_correct: String, callback: Callable):
  InventoryManager.instance.set_callable(callback)
  InventoryManager.instance.set_item_id_correct(item_id_correct)

func reset_item_status():
  InventoryManager.instance.reset_item_status()

func add_coin(value: int):
  Player.player.display_coin(value)

func change_scene(scene: PackedScene, tree: SceneTree, pos: Vector2):
  var player_last_idle_animation= PlayerMovement.instance.current_idle_animation
  var player_last_x_axis= PlayerMovement.instance.last_x_axis
  await Transition.instance.play_transition(false)
  tree.change_scene_to_packed(scene)
  await tree.process_frame
  Player.player.play_anim(player_last_idle_animation)
  PlayerMovement.instance.current_idle_animation= player_last_idle_animation
  PlayerMovement.instance.last_x_axis= player_last_x_axis
  PlayerMovement.instance.stop(true)
  Player.player.position= pos
  await Transition.instance.play_transition(true)
  
func open_inventory():
  OverlayManager.toggle_inventory()
