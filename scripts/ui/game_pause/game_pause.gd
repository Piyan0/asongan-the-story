extends Control

var list: VerticalListItem
@onready var button_resume: MenuLabel = %button_resume
@onready var button_options: MenuLabel = %button_options
@onready var button_exit: MenuLabel = %button_exit
@onready var options: OptionsSelectionMenu = $Options

const BUTTON_CALLBACK= 'q'
func _ready() -> void:
  
  if is_main():
    initiate()

func is_main():
  
  return get_tree().current_scene== self
  
func initiate():
  
  list= VerticalListItem.new(self)
  list.items= [
    button_resume, button_options, button_exit
  ]
  list.index_max= 2
  button_resume.set_meta(
    BUTTON_CALLBACK, func():
      print('resumed.')
      if not is_main():
        Mediator.air(Mediator.GAME_RESUMED)
  )
  button_options.set_meta(
    BUTTON_CALLBACK, func():
      print('opening options.')
      options.show()
      print(options.visible)
      options.set_initial_options()
      await get_tree().process_frame
      options.get_selection().is_active= true
      list.is_active= false
  )
  button_exit.set_meta(
    BUTTON_CALLBACK, func():
      get_tree().quit()
      print('exitted.')
  )
  
  list.selected_changed= func(s, a):
    for i in a:
      i.toggle_indicator(false)
    
    s.toggle_indicator(true)
  
  list.selected= func(s):
    s.get_meta(BUTTON_CALLBACK).call()
    
  list.is_active= true
  
  options.back_callback= func():
    options.hide()
    options.get_selection().is_active= false
    list.is_active= true
  
func close():
  
  if list:
    list.queue_free()
  
  for i in [%button_resume, %button_options, %button_exit]:
    i.toggle_indicator(false)

  options.hide()
  options.get_selection().is_active= false
