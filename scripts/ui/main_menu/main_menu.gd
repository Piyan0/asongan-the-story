extends Control
class_name MainMenu

signal game_started()

var list_main_menu: VerticalListItem
var list_credits: VerticalListItem
var list_manager: MultipleVerticalList
var stack: StackedOverlay
@onready var main_menu: Control = $main_menu
@onready var credits: Control = $credits
@onready var options: Control = $options
var is_game_started: bool= false

enum Menu{
  MAIN_MENU= 1,
  OPTIONS,
  CREDITS,
  EXIT,
}

static var instance: MainMenu
const BUTTON_CALLBACK= '_1'
func _ready() -> void:
  print(tr('BACK'))
  if not instance:
    instance= self
  
  list_manager= MultipleVerticalList.new()
  
  stack= StackedOverlay.new()
  stack.add_overlay(Menu.MAIN_MENU, main_menu)
  stack.add_overlay(Menu.CREDITS, credits)
  stack.add_overlay(Menu.OPTIONS, options)
  
  stack.set_current_overlay(Menu.MAIN_MENU)
  
  stack.overlay_changed.connect(func(id: Menu):
    match id:
      Menu.MAIN_MENU:
        pass

      Menu.OPTIONS:
        $options.set_process_input(true)
    )
  
  set_menu_list_callback()
  set_credits_list_callback()
  set_options_back()
  
  initiate_list_main_menu()
  initiate_list_credits()
  
  list_manager.add_list(Menu.MAIN_MENU, list_main_menu)
  list_manager.add_list(Menu.CREDITS, list_credits)
  list_manager.add_list(Menu.OPTIONS, $options.get_selection())
  list_manager.initial_active(Menu.MAIN_MENU)
  


func initiate_list_credits():
  
  list_credits= VerticalListItem.new(self)
  var items: Array[Label]= [$credits/menu_item]
  list_credits.items= items
  list_credits.index_max= 0
  
  list_credits.selected_changed= func(new: MenuLabel, all: Array):
    new.toggle_indicator(true)
    
  list_credits.selected= func(selected: MenuLabel):
    selected.get_meta(BUTTON_CALLBACK).call()
  
func initiate_list_main_menu():
  
  list_main_menu= VerticalListItem.new(self)
  list_main_menu.items= get_items()
  list_main_menu.index_max= 3
  
  list_main_menu.selected_changed= func(new: MenuLabel, all: Array[Variant]):
    for i in all:
      
      i.toggle_indicator(false)
    new.toggle_indicator(true)
    
  list_main_menu.selected= func(selected: MenuLabel):
    selected.get_meta(BUTTON_CALLBACK).call()   

func set_menu_list_callback() -> void:
  %button_quit.set_meta(BUTTON_CALLBACK, func():
    get_tree().quit()
    )
  
  %button_credits.set_meta(BUTTON_CALLBACK, func():
    #print(2)
    await stack.change_overlay(Menu.CREDITS)
    list_manager.change_focus(Menu.CREDITS)
    
    )
  
  %button_options.set_meta(BUTTON_CALLBACK, func():
    await stack.change_overlay(Menu.OPTIONS)
    list_manager.change_focus(Menu.OPTIONS)
    )
    
  %button_play.set_meta(BUTTON_CALLBACK, func():
    if not is_game_started:
      is_game_started= true
      Mediator.air(Mediator.GAME_STARTED)
    )
  

func set_credits_list_callback():
  $credits/menu_item.set_meta(BUTTON_CALLBACK, func():
    #print(3)
    await stack.change_overlay(Menu.MAIN_MENU)
    list_manager.change_focus(Menu.MAIN_MENU)
    )
  
func set_options_back():
  $options.back_callback= func():
    stack.change_overlay(Menu.MAIN_MENU)
    list_manager.change_focus(Menu.MAIN_MENU)
    #$options.set_process_input(false)

func get_items() -> Array[Label]:
  return [
    %button_play, %button_options, %button_credits, %button_quit
  ]
