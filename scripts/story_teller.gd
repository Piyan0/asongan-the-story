extends Control
signal next()


@onready var image: TextureRect = $image
@onready var label: Label = $Label
var is_fade: bool= false


func _ready() -> void:
  set_process_input(false)
  if is_main():
    start()
    await tween_label('Dia melihat anaknya yang berangkat sekolah dengan pakaian yang sudah usang...')
    await tween_label('Hanya bisa melihat...')
    await end()
    get_tree().quit()
    
    
func is_main():
  return get_tree().current_scene== self
  
  
func change_image(new_image:Texture2D, fade= true) -> void:
  image.texture= new_image
  
  
func tween_label(text: String, speed_6_char= 0.4) -> void:
  var t: Tween
  if is_fade:
   
    t= create_tween()
    t.tween_property(label, 'modulate', Color('ffffff00'), 0.3)
    await t.finished
    label.modulate= Color('ffffff')
  else:
    is_fade= true
    
  label.visible_ratio= 0
  label.text= text
  t= create_tween()
  t.tween_property(
    label, 'visible_ratio',
    1, get_time(speed_6_char, label.text.length()),
  )
  await t.finished
  await next


func get_time(speed: float, text_length: int) -> float:
  var divide_6: float= float(text_length)/ 6
  return divide_6* speed
  

func start():
  set_process_input(true)
  is_fade= true
  label.text= ''


func end():
  set_process_input(false)
  var t: Tween
  t= create_tween()
  t.tween_property(label, 'modulate', Color('ffffff00'), 0.3)
  await t.finished
  is_fade= false

  
func _input(event: InputEvent) -> void:
  if event.is_action_pressed("left_click") or event.is_action_pressed('z') or event.is_action_pressed('ui_accept'):
    next.emit()
