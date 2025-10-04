extends ColorRect
class_name ItemSlot

@export var pointer : TextureRect
@export var anim_player : AnimationPlayer
@export var icon: TextureRect
var is_has_item: bool= false
var is_on_top= false
var is_tweening= false

func active() -> void:
  if is_on_top:
    return
  is_on_top= true
  var add_position : float= -3
  var t : Tween= create_tween()
  t.tween_property(self, 'position:y', self.position.y + add_position, 0.05)
  is_tweening= true
  await t.finished
  is_tweening= false
  pointer.show()
  anim_player.play('blip')


func inactive() -> void:
  if is_on_top == false:
    return
  is_on_top= false
  pointer.hide()
  var add_position : float= -3
  var t : Tween= create_tween()
  t.tween_property(self, 'position:y', self.position.y - add_position, 0.05)
  is_tweening= true
  await t.finished
  is_tweening= false
  anim_player.stop()

func set_icon(new_icon: CompressedTexture2D) -> void:
  icon.texture= new_icon
  
func get_is_tweening() -> bool:
  return is_tweening
  
  
