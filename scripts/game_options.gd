extends Node
class_name GameOptions

#SAVE
static var settings: Dictionary[String, Variant]= {
  'change_language': 'en-US',
  'toggle_fullscreen': true,
  'toggle_vsync': true,
  'change_audio': 1
}


enum MoveKeys {
  WASD,
  ARROW_KEYS
}

enum ActionKeys{
  ZXC,
  EQF,
}

func apply_settings(_settings):
  for i in _settings:
    #print(i)
    self[i].call(_settings[i])
    
  
func change_language(id: String):
  print('language changed to ', id)
  settings.change_language= id
  TranslationServer.set_locale(id)
  #setting_changed()

func toggle_fullscreen(is_fullscreen: bool):
  settings.toggle_fullscreen= is_fullscreen
  if is_fullscreen:
    DisplayServer.window_set_mode.call_deferred(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
    return
    
  DisplayServer.window_set_mode.call_deferred(DisplayServer.WINDOW_MODE_WINDOWED)
  #setting_changed()
  

func toggle_vsync(enable_vsync: bool):
  settings.toggle_vsync= enable_vsync
  if enable_vsync:
    DisplayServer.window_set_vsync_mode.call_deferred(DisplayServer.VSYNC_ENABLED)
    return
  
  DisplayServer.window_set_vsync_mode.call_deferred(DisplayServer.VSYNC_DISABLED)
  #setting_changed()

func change_audio(normalized_float: float):
  settings.change_audio= normalized_float
  AudioServer.set_bus_volume_db(0, linear_to_db(normalized_float))
  #setting_changed()
  
func setting_changed():
  Saveable.set_data('settings', settings)
  Saveable.save_to_file()
