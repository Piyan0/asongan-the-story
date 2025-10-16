extends Node

enum SFX{
  UI_SELECT,
  UI_NOTIF,
  UI_HOVER,
  UI_CANCEL,
  UI_ALERT,
  UI_ACCEPT,
  UI_POP_UP,
  UI_TRANSACTION,
  UI_INVENTORY,
  CAR_HONK,
  
}

enum BGM{
  BGM_AMBIENCE=50
}

var sounds= {}
@onready var ui_select: AudioStreamPlayer = $ui_select
@onready var ui_notif: AudioStreamPlayer = $ui_notif
@onready var ui_hover: AudioStreamPlayer = $ui_hover
@onready var ui_cancel: AudioStreamPlayer = $ui_cancel
@onready var ui_alert: AudioStreamPlayer = $ui_alert
@onready var ui_accept: AudioStreamPlayer = $ui_accept
@onready var ui_pop_up: AudioStreamPlayer = $ui_pop_up
@onready var ui_transaction: AudioStreamPlayer = $ui_transaction
@onready var ui_inventory: AudioStreamPlayer = $ui_inventory
@onready var car_honk: AudioStreamPlayer = $car_honk
@onready var bgm_ambience: AudioStreamPlayer = $bgm_ambience
 
func _ready() -> void:
  sounds= {
    SFX.UI_SELECT: ui_select,
    SFX.UI_NOTIF: ui_notif,
    SFX.UI_HOVER: ui_hover,
    SFX.UI_CANCEL: ui_cancel,
    SFX.UI_ALERT: ui_alert,
    SFX.UI_ACCEPT: ui_accept,
    SFX.UI_POP_UP: ui_pop_up,
    SFX.UI_TRANSACTION: ui_transaction,
    SFX.UI_INVENTORY: ui_inventory,
    SFX.CAR_HONK: car_honk,
    BGM.BGM_AMBIENCE: bgm_ambience,
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
  

  
