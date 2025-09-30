extends ColorRect
class_name InventoryItem
@export var id: String

var is_selected: bool = false
var is_holding_item: bool= false
@onready var icon: TextureRect = $icon
func set_texture(new_texture: CompressedTexture2D) -> void:
  icon.texture= new_texture
  
@onready var animation_player: AnimationPlayer = $AnimationPlayer
func blip_animation(is_stop: bool) -> void:
  animation_player.stop()
  if is_stop:
    animation_player.play('stop_blip')
  else:
    animation_player.play('hint_blip')

@onready var blip_texture: TextureRect = $blip
func blip(is_show: bool)  -> void:
  blip_texture.visible= is_show

func set_id(new_id: String) -> void:
  id= new_id

@onready var in_slot_status: TextureRect = $in_slot_status

func in_slot(is_in_slot: bool) -> void:
  in_slot_status.visible= is_in_slot
