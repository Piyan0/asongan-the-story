extends Node
class_name C_001

func fn():
  await Transition.instance.fade_in()
  Transition.instance.fade_out()
  Player.player.toggle_camera(false)
  MainRoad.i.toggle_camera(true)
  MainRoad.i.set_camera_pos(Vector2(837, 241))
  VisibleControl.set_state_by_id(
    GameState.Visible.MAIN_ROAD__USTADZ_FULL, true
  )
  var walk= Walk.new()
  walk.set_targ(
    VisibleControl.get_first_member(
      GameState.Visible.MAIN_ROAD__USTADZ_FULL
    ) 
  )
  
  await walk.walk(
    'x:866'
  )
  await walk.walk(
    'y:377'
  )
  
  await MainRoad.i.tween_camera(
    Vector2(881, 374)
  )
  
  await walk.jump()
  await walk.jump()
  await walk.jump()
  
  await Transition.instance.fade_in()
  Transition.instance.fade_out()
  
  VisibleControl.set_state_by_id(
    GameState.Visible.MAIN_ROAD__USTADZ_FULL, false
  )
  MainRoad.i.toggle_bazzard_blockade(false)
  
  await Mediator.get_tree().create_timer(2).timeout
  await Transition.instance.fade_in()
  
  Transition.instance.fade_out()
  Player.player.toggle_camera(!false)
  MainRoad.i.toggle_camera(!true)
