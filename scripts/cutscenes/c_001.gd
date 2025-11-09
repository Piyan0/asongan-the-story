extends Node
class_name C_001

func fn_000():
  await Transition.instance.fade_in()
  Transition.instance.fade_out()
  Player.player.toggle_camera(false)
  MainRoad.i.toggle_camera(true)
  MainRoad.i.set_camera_pos(Vector2(330, 186))
  
  var walk= Walk.new()
  walk.set_targ(
    VisibleControl.get_first_member(
      GameState.Visible.MAIN_ROAD__USTADZ
    )
  )
  
  walk.pos(
    '20:164'
  )
  
  VisibleControl.set_state_by_id(
    GameState.Visible.MAIN_ROAD__USTADZ,
    true
  )
  MainRoad.i.toggle_ustadz_cols(true)
  
  await walk.walk(
    'x:313'
  )
  
  await Transition.instance.fade_in()
  Transition.instance.fade_out()
  Player.player.toggle_camera(not false)
  MainRoad.i.toggle_camera(not true)
  
func fn_001():
  
  MainRoad.i.toggle_ustadz_cols(false)
  VisibleControl.set_state_by_id(
    GameState.Visible.MAIN_ROAD__USTADZ,
    false
  )
  
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

func fn_002():
  await Transition.instance.fade_in()
  Transition.instance.fade_out()
  Player.player.toggle_camera(false)
  MainRoad.i.toggle_camera(true)
  MainRoad.i.set_camera_pos(
    Vector2(319, 197)
  )
  var walk= Walk.new()
  walk.set_targ(
    MainRoad.i.get_punk_car_with_people()
  )
  walk.pos('-93:257')
  await walk.walk('x:445')
  
  await Transition.instance.fade_in()
  
  walk.pos(
    '-118:56'
  )
  
  VisibleControl.set_state_by_id(
    GameState.Visible.MAIN_ROAD__CAR_PUNK,
    true
  )
  VisibleControl.set_state_by_id(
    GameState.Visible.MAIN_ROAD__PUNKER,
    true
  )
  MainRoad.i.toggle_punker_colls(true)
  
  await Transition.instance.fade_out()
  
  await MainRoad.i.tween_camera(
    Vector2(336, 180)
  )
  
  await Transition.instance.fade_in()
  Transition.instance.fade_out()
  
  Player.player.toggle_camera(!false)
  MainRoad.i.toggle_camera(!true)

func fn_003():
  await Transition.instance.fade_in()
  Transition.instance.fade_out()
  Player.player.toggle_camera(false)
  MainRoad.i.toggle_camera(true)
  MainRoad.i.set_camera_pos(
    Vector2(957, 180)
  )
  
  MainRoad.i.toggle_punker_colls(false)
  
  VisibleControl.set_state_by_id(
    GameState.Visible.MAIN_ROAD__PUNKER,
    false
  )
  VisibleControl.set_state_by_id(
    GameState.Visible.MAIN_ROAD__CAR_PUNK,
    false
  )
  
  var walk= Walk.new()
  walk.set_targ(
    MainRoad.i.get_punk_car_with_people()
  )
  walk.pos(
    '565:261'
  )
  await walk.walk(
    'x:1366'
  )
  
  await Transition.instance.fade_in()
  Transition.instance.fade_out()
  Player.player.toggle_camera(!false)
  MainRoad.i.toggle_camera(!true)
