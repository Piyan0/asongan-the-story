extends Control
class_name OptionsSelectionMenu

@export var show_bg: bool= false
var list: VerticalListItem
var language_options: OptionsSelection
var move_keys_options: OptionsSelection
var fullscreen_options: OptionsSelection
var vsync_options: OptionsSelection
var audio_options: OptionsSelection
var actions_key_options: OptionsSelection

var back_callback: Callable= func():
  print('back.')

var multiple_options: MultipleOptionsSelection

enum LabelUI{
  TITTLE_LANGUAGE,
  TITTLE_FULSCREEN,
  TITTLE_AUDIO,
  BACK,
}

enum OptionsID{
  LANGUAGE= 1,
  FULLSCREEN,
  VSYNC,
  AUDIO,
}

var label_ui={
  LabelUI.TITTLE_LANGUAGE: null,
  LabelUI.TITTLE_FULSCREEN: null,
  LabelUI.TITTLE_AUDIO: null,
  LabelUI.BACK: null,
}
var is_list_overflowed: bool= false

#SAVE
static var saved_setting_index= {
  OptionsID.LANGUAGE: 0,
  OptionsID.FULLSCREEN:0,
  OptionsID.VSYNC:0,
  OptionsID.AUDIO:9,
}

func _ready() -> void:
  if show_bg:
    $NinePatchRect.show()
  label_ui[LabelUI.TITTLE_LANGUAGE]= %language_options_ui.get_tittle_label()
  label_ui[LabelUI.TITTLE_FULSCREEN]= %fullscreen_ui.get_tittle_label()
  label_ui[LabelUI.TITTLE_AUDIO]= %audio_ui.get_tittle_label()
  label_ui[LabelUI.BACK]= %back.get_label()

  %language_options_ui.set_meta('id', OptionsID.LANGUAGE)
  %fullscreen_ui.set_meta('id', OptionsID.FULLSCREEN)
  %vsync_ui.set_meta('id', OptionsID.VSYNC)
  %audio_ui.set_meta('id', OptionsID.AUDIO)
  
  list= VerticalListItem.new(self)
  list.items= get_items()
  list.items.push_back(%back)
  #print(list.items)
  list.index_max= 4
  
  list.selected= func(s):
    if s== %back:
      back()
      
  list.selected_changed= func(n, a):
    #print(n)
    for i in a:
      #print(i)
      i.toggle_indicator(false)
    n.toggle_indicator(true)
    
    if n.has_meta('id'):
      multiple_options.change_focus(n.get_meta('id'))
    else:
      multiple_options.pause_focus()
          
  set_language_options()
  set_fullscreen_options()
  set_vsync_options()
  set_audio_options()
 
  
  multiple_options= MultipleOptionsSelection.new()
  multiple_options.add_selection(OptionsID.LANGUAGE, language_options)
  multiple_options.add_selection(OptionsID.FULLSCREEN, fullscreen_options)
  multiple_options.add_selection(OptionsID.VSYNC, vsync_options)
  multiple_options.add_selection(OptionsID.AUDIO, audio_options)
  
  if get_tree().current_scene== self:
    list.is_active= true
  
func get_items() -> Array:
  return [
%language_options_ui, %fullscreen_ui, %vsync_ui, %audio_ui,
]

@onready var language_options_ui: OptionItem = %language_options_ui

func set_language_options():
  language_options= OptionsSelection.new()
  
  var option_1= OptionsSelection.Options.new()
  option_1.tittle= 'Indonesia'
  option_1.callback= func(game_options: GameOptions):
    game_options.change_language('id-ID')
    #TranslationServer.set_locale('id-ID')
  
  var option_2= OptionsSelection.Options.new()
  option_2.tittle= 'English'
  option_2.callback= func(game_options: GameOptions):
    game_options.change_language('en-US')
    #TranslationServer.set_locale('en-US')
    
  
  language_options.add_options(option_2)
  language_options.add_options(option_1)
  
  language_options.option_changed.connect(func(option: OptionsSelection.Options, direction: String):
    language_options_ui.set_text(option.tittle, direction)
    option.callback.call(GameOptions.new())
    saved_setting_index[OptionsID.LANGUAGE]= language_options.current_index
    Mediator.air(Mediator.SETTINGS_CHANGED, [GameOptions.settings])
    )
  language_options.option_ready.connect(func(option: OptionsSelection.Options):
    language_options_ui.set_text(option.tittle, '')
    )
  language_options.initial_option()
  self.add_child.call_deferred(language_options)


@onready var fullscreen_ui: OptionItem = %fullscreen_ui

func set_fullscreen_options():
  fullscreen_options= OptionsSelection.new()
  
  var option_1= OptionsSelection.Options.new()
  option_1.tittle= 'ON'
  option_1.callback= func(game_options: GameOptions):
    game_options.toggle_fullscreen(true)
    
  var option_2= OptionsSelection.Options.new()
  option_2.tittle= 'OFF'
  option_2.callback= func(game_options: GameOptions):
    game_options.toggle_fullscreen(false)
  
  fullscreen_options.add_options(option_1)
  fullscreen_options.add_options(option_2)
  
  fullscreen_options.option_changed.connect(func(option: OptionsSelection.Options, direction: String):
    fullscreen_ui.set_text(option.tittle, direction)
    option.callback.call(GameOptions.new())
    saved_setting_index[OptionsID.FULLSCREEN]= fullscreen_options.current_index
    Mediator.air(Mediator.SETTINGS_CHANGED, [GameOptions.settings])
    
    )
  fullscreen_options.option_ready.connect(func(option: OptionsSelection.Options):
    fullscreen_ui.set_text(option.tittle, '')
    )
    
  fullscreen_options.initial_option()
  self.add_child.call_deferred(fullscreen_options)

@onready var audio_ui: OptionItem = %audio_ui

func set_audio_options():
  audio_options= OptionsSelection.new()
  
  var option_1= OptionsSelection.Options.new()
  option_1.tittle= '0.1'
  option_1.callback= func(game_options: GameOptions):
    game_options.change_audio(0.1)
  var option_2= OptionsSelection.Options.new()
  option_2.tittle= '0.2'
  option_2.callback= func(game_options: GameOptions):
    game_options.change_audio(0.2)
  var option_3= OptionsSelection.Options.new()
  option_3.tittle= '0.3'
  option_3.callback= func(game_options: GameOptions):
    game_options.change_audio(0.3)
  var option_4= OptionsSelection.Options.new()
  option_4.tittle= '0.4'
  option_4.callback= func(game_options: GameOptions):
    game_options.change_audio(0.4)
  var option_5= OptionsSelection.Options.new()
  option_5.tittle= '0.5'
  option_5.callback= func(game_options: GameOptions):
    game_options.change_audio(0.5)
  var option_6= OptionsSelection.Options.new()
  option_6.tittle= '0.6'
  option_6.callback= func(game_options: GameOptions):
    game_options.change_audio(0.6)
  var option_7= OptionsSelection.Options.new()
  option_7.tittle= '0.7'
  option_7.callback= func(game_options: GameOptions):
    game_options.change_audio(0.7)
  var option_8= OptionsSelection.Options.new()
  option_8.tittle= '0.8'
  option_8.callback= func(game_options: GameOptions):
    game_options.change_audio(0.8)
  var option_9= OptionsSelection.Options.new()
  option_9.tittle= '0.9'
  option_9.callback= func(game_options: GameOptions):
    game_options.change_audio(0.9)
  var option_10= OptionsSelection.Options.new()
  option_10.tittle= '1'
  option_10.callback= func(game_options: GameOptions):
    game_options.change_audio(1.0)

  audio_options.add_options(option_1)
  audio_options.add_options(option_2)
  audio_options.add_options(option_3)
  audio_options.add_options(option_4)
  audio_options.add_options(option_5)
  audio_options.add_options(option_6)
  audio_options.add_options(option_7)
  audio_options.add_options(option_8)
  audio_options.add_options(option_9)
  audio_options.add_options(option_10)
  
  audio_options.option_changed.connect(func(option: OptionsSelection.Options, direction: String):
    audio_ui.set_text(option.tittle, direction)
    option.callback.call(GameOptions.new())
    saved_setting_index[OptionsID.AUDIO]= audio_options.current_index
    Mediator.air(Mediator.SETTINGS_CHANGED, [GameOptions.settings])
    )
  audio_options.option_ready.connect(func(option: OptionsSelection.Options):
    audio_ui.set_text(option.tittle, '')
    )
  
  #audio_options.initial_index(9)
  audio_options.initial_option()
  self.add_child.call_deferred(audio_options)

@onready var vsync_ui: OptionItem = %vsync_ui

func set_vsync_options():
  vsync_options= OptionsSelection.new()
  
  var option_1= OptionsSelection.Options.new()
  option_1.tittle= 'ON'
  option_1.callback= func(game_options: GameOptions):
    game_options.toggle_vsync(true)
    
  var option_2= OptionsSelection.Options.new()
  option_2.tittle= 'OFF'
  option_2.callback= func(game_options: GameOptions):
    game_options.toggle_vsync(false)
  
  vsync_options.add_options(option_1)
  vsync_options.add_options(option_2)
  
  vsync_options.option_changed.connect(func(option: OptionsSelection.Options, direction: String):
    vsync_ui.set_text(option.tittle, direction)
    option.callback.call(GameOptions.new())
    saved_setting_index[OptionsID.VSYNC]= vsync_options.current_index
    Mediator.air(Mediator.SETTINGS_CHANGED, [GameOptions.settings])
    
    )
  vsync_options.option_ready.connect(func(option: OptionsSelection.Options):
    vsync_ui.set_text(option.tittle, '')
    )
    
  self.add_child.call_deferred(vsync_options)

func set_initial_options():
  vsync_options.initial_index(int(saved_setting_index[OptionsID.VSYNC]))
  language_options.initial_index(int(saved_setting_index[OptionsID.LANGUAGE]))
  fullscreen_options.initial_index(int(saved_setting_index[OptionsID.FULLSCREEN]))
  audio_options.initial_index(int(saved_setting_index[OptionsID.AUDIO]))
  
  vsync_options.initial_option()
  language_options.initial_option()
  fullscreen_options.initial_option()
  audio_options.initial_option()

func continue_selection():
  list.is_active= true
  list.set_index_active(0)
  %back.toggle_indicator(false)
  multiple_options.resume_focus()


func back():
  save_setting()
  back_callback.call()
  list.is_active= false
  
  
func save_setting():
  saved_setting_index[OptionsID.LANGUAGE]= language_options.current_index
  saved_setting_index[OptionsID.FULLSCREEN]= fullscreen_options.current_index
  saved_setting_index[OptionsID.VSYNC]= vsync_options.current_index
  saved_setting_index[OptionsID.AUDIO]= audio_options.current_index

func get_selection() -> VerticalListItem:
  return list


  
