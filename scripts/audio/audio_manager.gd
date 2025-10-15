extends Node

enum SFX{
  UI_ACCEPT=0,
  UI_ALERT,
  UI_CONFRIM,
}

enum BGM{
  BGM_SAD=50
}

var sounds= {}

func _ready() -> void:
  sounds= {
    SFX.UI_ACCEPT: $ui_accept,
    SFX.UI_ALERT: $ui_alert,
    SFX.UI_CONFRIM: $ui_confirm,
    BGM.BGM_SAD: $bgm_sad,
    }
    

func play(id: int):
  sounds[id].play()


func stop(id: int, is_fade= false):
  if is_fade:
    for i in 20:
      sounds[id].volume_db-= 2
      await get_tree().create_timer(0.1).timeout
    
  sounds[id].volume_db= 0
  sounds[id].stop()
  

  
