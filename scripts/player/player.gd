extends CharacterBody2D
class_name Player
signal bubble_played()
signal bubble_finished()
signal changing_side_finished()

@export var movement_core : TopdownMovement
@export var sprite : AnimatedSprite2D
@export var items_slot : Control
@export var bubble : AnimatedSprite2D
@export var coin_label: Label
@export var coin_animation: AnimationPlayer
static var player: Player

func _ready() -> void:
  if player== null:
    player= self 


func play_bubble(id: String) -> void:
  bubble.play(id)
  set_process_input(false)
  bubble_played.emit()
  await bubble.animation_finished
  set_process_input(true)
  bubble_finished.emit()  

func display_coin(value: int):
  var duration: float= 0.5
  coin_label.text= '+'+str(value)
  coin_label.show()
  coin_animation.play('pop')
  await get_tree().create_timer(duration).timeout
  coin_label.hide()
 
