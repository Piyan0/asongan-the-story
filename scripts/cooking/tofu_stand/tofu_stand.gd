extends Control
class_name TofuStand

@onready var tofus= [
  $Control/tofu/TextureRect, $Control/tofu/TextureRect2, $Control/tofu/TextureRect3, $Control/tofu/TextureRect4, $Control/tofu/TextureRect5, $Control/tofu/TextureRect6
]
var current_tofu: int= 0
func _ready() -> void:
  self.add_to_group('TofuStand')
  
  $Control/tofu/TextureRect7.hide()
  for i in tofus:
    i.hide()
  
func add_tofu():
  var i = tofus[current_tofu]
  i.show()
  i.get_child(0).play('new_animation')
  
  
  current_tofu+= 1

func add_rice_rolls():
  $Control/tofu/TextureRect7.show()
  $Control/tofu/TextureRect7.get_child(0).play('new_animation')
  
func hide_all():
  for i in [
    $Control/tofu/TextureRect7, $Control/tofu/TextureRect, $Control/tofu/TextureRect2, $Control/tofu/TextureRect3, $Control/tofu/TextureRect4, $Control/tofu/TextureRect5, $Control/tofu/TextureRect6
  ]:
    i.hide()

func get_ingredient_list() -> Array[Ingredient]:
  return [
    $tofu, $rice_rolls, $chilly
  ]


@onready var mouse: TextureRect = $mouse

func _physics_process(delta: float) -> void:
  mouse.position= get_global_mouse_position()
