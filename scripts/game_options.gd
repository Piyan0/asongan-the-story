extends Node
class_name GameOptions

#SAVE
static var settings: Dictionary[String, Variant]= {
  'change_language': Language.ID,
  'toggle_fullscreen': false,
  'toggle_vsync': true,
  'change_audio': 1
}

enum Language{
  ID,
  EN
}

enum MoveKeys {
  WASD,
  ARROW_KEYS
}

enum ActionKeys{
  ZXC,
  EQF,
}

func apply_settings():
  for i in settings:
    self[i].call(settings[i])
    
  
func change_language(id: Language):
  print('language changed to ', id)
  settings.change_language= id

func toggle_fullscreen(is_fullscreen: bool):
  settings.toggle_fullscreen= is_fullscreen
  if is_fullscreen:
    DisplayServer.window_set_mode.call_deferred(DisplayServer.WINDOW_MODE_FULLSCREEN)
    return
    
  DisplayServer.window_set_mode.call_deferred(DisplayServer.WINDOW_MODE_WINDOWED)
  
  

func toggle_vsync(enable_vsync: bool):
  settings.toggle_vsync= enable_vsync
  if enable_vsync:
    DisplayServer.window_set_vsync_mode.call_deferred(DisplayServer.VSYNC_ENABLED)
    return
  
  DisplayServer.window_set_vsync_mode.call_deferred(DisplayServer.VSYNC_DISABLED)
  

func change_audio(normalized_float: float):
  settings.change_audio= linear_to_db(normalized_float)
  AudioServer.set_bus_volume_db(0, linear_to_db(normalized_float))
