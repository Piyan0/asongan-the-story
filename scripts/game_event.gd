extends Node
class_name GameEvent

func add_coin(value: int):
  Player.player.display_coin(value)

func change_scene(scene: PackedScene, tree: SceneTree, pos: Vector2):
  if not GameState.can_enter_other_area:
    Mediator.air(Mediator.PLAYER_CANT_ENTER_OTHER_AREA)
    return
    
  Mediator.air(Mediator.TRAIN_TIMER_TOGGLE, [false])
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
  Mediator.air(Mediator.TRAIN_TIMER_TOGGLE, [true])
  Mediator.air(Mediator.SCENE_CHANGED)
