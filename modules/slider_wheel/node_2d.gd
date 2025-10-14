extends Control

signal slide_finished()

@onready var actual: TextureRect = $actual
@onready var follow: TextureRect = $follow
@onready var start_source: TextureRect = $start
@onready var origin_source: Control = $origin

var is_idle= true
var is_succed: bool= false
var _looped= func(_loop: int): pass
var total_loop := 0
var start_pos= Vector2(218, 235)
var origin: Vector2
var is_dragging: bool= false
var is_mouse_inside_dragging_area: bool= false
var last_vect: Vector2
var max_length_from_actual= 40
var actual_length_orbit= Vector2(66, 66)
var offset= Vector2(10, 10)
var pop
var loop_nodes: Dictionary
var loop_max := 2
const pop_class= preload("./touch_pop.gd")

func _ready() -> void:
  
  if not is_main():
    set_process(false)
    set_process_input(false)
    hide()
    
  var loop_pop_1= pop_class.new()
  loop_pop_1.target= $TextureRect2
  var loop_pop_2= pop_class.new()
  loop_pop_2.target= $TextureRect3
  loop_nodes={
    1:{
      'node': $TextureRect2,
      'pop': loop_pop_1,
    },
    2: {
      'node': $TextureRect3,
      'pop': loop_pop_2
    }
  }
  pop= pop_class.new()
  pop.target= $follow/TextureRect
  if is_main():
    start()


func show_progress(_loop: int):
  loop_nodes[_loop].node.modulate= Color('5b7d73')
  await loop_nodes[_loop].pop.pop()


func reset_progress():
  loop_nodes[2].node.modulate= Color('8c7c79')
  await loop_nodes[2].pop.pop()
  loop_nodes[1].node.modulate= Color('8c7c79')
  await loop_nodes[1].pop.pop()
  
  
func play(anim: String, is_backwards: bool= false):
  is_idle= false
  if is_backwards:
    $AnimationPlayer.play_backwards(anim)
  else:
    $AnimationPlayer.play(anim)
  await $AnimationPlayer.animation_finished
  is_idle= true

func on_looped(loop):
  #print(4)
  await show_progress(loop)
  if loop >= loop_max:
    set_succed(true)
    #await get_tree().create_timer(1).timeout
    await reset_progress()
    await close()
    slide_finished.emit()
    

func set_succed(cond: bool):
  is_succed= cond
  
func start():
  show()
  set_process_input(true)
  set_process(true)
  last_vect= start_pos
  follow.position= start_pos
  actual.position= start_pos
  start_source.position= start_pos- offset
  origin= origin_source.position
  #print(origin)
  $actual/TextureRect2.mouse_entered.connect(func():
    is_mouse_inside_dragging_area= true
    #print(1)
    )

  $actual/TextureRect2.mouse_exited.connect(func():
    #print(2)
    if not is_dragging:
      is_mouse_inside_dragging_area= false
    )
  await play('show')

func delete_connections(_signal: Signal) -> void:
  
  for i in _signal.get_connections():
    _signal.disconnect(i.callable)
  
  #print(_signal.get_connections())
  
  
func is_main():
  
  return get_tree().current_scene== self
  
  
func close():
  is_threshold_passed= false
  reset_progress()
  total_loop= 0
  delete_connections(
    $actual/TextureRect2.mouse_entered
  ) 
  delete_connections(
    $actual/TextureRect2.mouse_exited
  )
  pop.pop()
  is_dragging= false
  set_process_input(false)
  set_process(false)
  if not is_main():
    await play('show', true)
    hide()
  
  
func _input(event: InputEvent) -> void:
  
  if event is InputEventMouse:
    if event.is_action_pressed("left_click") and is_mouse_inside_dragging_area:
      is_dragging= true
      pop.pop()
    elif event.is_action_released("left_click"):
      is_dragging= false
  
  if event is InputEventMouseMotion and is_dragging:
    #print(1)  
    var dir= event.position- origin - self.position
    dir= dir.normalized()
    var actual_pos= dir* actual_length_orbit
  
    if not is_clockwise(last_vect, dir):
      return
      
    last_vect= dir
    actual.position= origin+ actual_pos
    
    var length_from_actual= (actual.position- follow.position).length()
    if length_from_actual>= max_length_from_actual:
      is_dragging= false


var is_threshold_passed: bool= false
func _process(delta: float) -> void:
  #print(actual.position)
  follow.position= rotate_around_pivot(
    follow.position,
    actual.position,
    origin,
    #1,
    2.5* delta, # 0.02 in 60fps.
  )
  var delta_rotation= get_angle_clockwise(
      follow.position,
      start_pos,
      origin
    )
  var is_intersect_with_start_pos= is_control_intersect(
    follow,
    $ColorRect,
  )
  #print(delta_rotation)
  if delta_rotation<-180 and not is_intersect_with_start_pos:
    is_threshold_passed= true
    
  if is_threshold_passed and is_intersect_with_start_pos:
    total_loop+= 1
    _looped.call(total_loop)
    on_looped(total_loop)
    is_threshold_passed= false
  
  #print(delta_rotation)


func is_control_intersect(control_a: Control, control_b: Control) -> bool:
  
  var x= Rect2(
    control_a.position,
    control_a.size
  )
  var y= Rect2(
    control_b.position,
    control_b.size
  )
  
  return x.intersects(y)


func get_angle_clockwise(vect_a: Vector2, target: Vector2, center_pivot: Vector2) -> float:
  
  var angle= (center_pivot- vect_a).angle_to(
    center_pivot- target
  )
  angle= rad_to_deg(angle)
  #print(angle, ' \n')
  if angle> 0:
    angle-= 360
  return angle
  
func rotate_around_pivot(start_pos: Vector2, dest_pos: Vector2, center_pivot: Vector2, factor_value: float):
  
  var vect_dest= (dest_pos) - center_pivot
  var vect_move= (start_pos) - center_pivot
  var dest_angle= rad_to_deg( vect_move.angle_to(vect_dest) )
  var targ_angle= lerp(
    0.0,
    dest_angle,
    factor_value
  )
  #printt(dest_angle, move_angle, targ_angle)
  return center_pivot+ vect_move.rotated( deg_to_rad( targ_angle ) )
  
  
func is_clockwise(a, b):
  return a.cross(b)>0
  
