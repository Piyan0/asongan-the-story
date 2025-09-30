extends Camera2D
class_name Camera

static var instance: Camera
var base_size= Vector2(640, 360)
var current_pos= Vector2(0,0)

func _ready() -> void:
  if not instance:
    instance= self
  
func move_camera(pos: Vector2, duration: float):
  var t: Tween= create_tween().set_trans(Tween.TRANS_SINE)
  t.tween_property(self, 'position', pos, duration)
  await t.finished

func update_camera_pos():
  await move_camera(Vector2(base_size* current_pos), 0)
  
func move_left():
  current_pos.x-= 1
  update_camera_pos()

func move_right():
  current_pos.x+= 1
  update_camera_pos()

func move_down():
  current_pos.y+= 1
  update_camera_pos()

func move_up():
  current_pos.y-= 1
  update_camera_pos()
  
