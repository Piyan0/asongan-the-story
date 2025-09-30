extends Sprite2D

func _ready() -> void:
  await get_tree().create_timer(randf_range(0.1, 0.5)).timeout
  $AnimationPlayer.play('new_animation')
