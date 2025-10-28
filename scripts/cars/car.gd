extends Node
class_name Car
signal stopped()
signal moved(_position)
signal arrived()
var parent_node: Node2D
var is_moving: bool= false
var tween: Tween
const base_speed: float= 200#90

enum CarID{
  CAR_FIRST_ROW= -1,
  CAR_SECOND_ROW= -2,
  CAR_STOP= 0,
  CAR_001= 1,
  CAR_002,
  CAR_003,
  CAR_004,
  CAR_005,
  CAR_006,
  CAR_007,
  CAR_008,
  CAR_009,
  CAR_010,
  CAR_011,
  CAR_012,
  CAR_013,
  CAR_014,
  CAR_015,
  CAR_016,
  CAR_017,
  CAR_018,
  CAR_019,
  CAR_020,
  CAR_021,
  CAR_022,
  CAR_023,
  CAR_024,
  CAR_025,
  CAR_026,
  CAR_027,
  CAR_028,
  CAR_029,
  CAR_030,
}
static var current_car: CarScene
static var car_back_point= {
  CarID.CAR_001: 0,
  CarID.CAR_002: 0,
  CarID.CAR_003: 0,
  CarID.CAR_004: 0,
  CarID.CAR_005: 0,
  CarID.CAR_006: 0,
  CarID.CAR_007: 0,
  CarID.CAR_008: 0,
  CarID.CAR_009: 0,
  CarID.CAR_010: 0,
  CarID.CAR_011: 0,
  CarID.CAR_012: 0,
  CarID.CAR_013: 0,
  CarID.CAR_014: 0,
  CarID.CAR_015: 0,
  CarID.CAR_016: 0,
  CarID.CAR_017: 0,
  CarID.CAR_018: 0,
  CarID.CAR_019: 0,
  CarID.CAR_020: 0,
  CarID.CAR_021: 0,
  CarID.CAR_022: 0,
  CarID.CAR_023: 0,
  CarID.CAR_024: 0,
  CarID.CAR_025: 0,
  CarID.CAR_026: 0,
  CarID.CAR_027: 0,
  CarID.CAR_028: 0,
  CarID.CAR_029: 0,
  CarID.CAR_030: 0,
}

static func get_back_point(id: CarID) -> Vector2:
  return car_back_point[id]
  
func move_car(delay: float, _position_return: Callable, is_broadcast: bool= false):
  await parent_node.get_tree().create_timer(delay).timeout
  tween= parent_node.create_tween()
  moved.emit(_position_return.call())
  var _position= _position_return.call()
  is_moving= true
  tween.tween_property(parent_node, 'position', _position, get_time(base_speed, _position))
  await tween.finished
  stopped.emit()
  if is_broadcast:
    arrived.emit()

func get_time(speed: float, move_pos: Vector2) -> float:
  var distance: float= parent_node.position.distance_to(move_pos)
  return float(distance/ speed)
  
func stop():
  if tween:
    tween.pause()
  stopped.emit()

func continue_move():
  
  moved.emit()
  tween.play()
