extends Control

var item_ui: PackedScene
var inventory: Inventory
var list: GridListItem

@onready var container: FlowContainer = %container


var selected: Control
var META_ITEM= 'q'
var current_slot: int
func _ready() -> void:
  item_ui= load("res://scenes/ui/inventory/item_ui.tscn")
  #TranslationServer.set_locale('id-ID')
  if get_tree().current_scene== self:
    display_inventory()
  #initiate_selection()
  
func display_inventory():
  inventory= Inventory.new()
  fill(inventory)
  
  for i in inventory.items:
    var _item_ui= item_ui.instantiate()
    _item_ui.set_meta(META_ITEM, i)
    container.add_child(_item_ui)
    _item_ui.set_text(i.item_name)
    _item_ui.set_texture(i.icon)
  
  initiate_selection()
  set_slot(inventory.get_current_inventory_size())


func fill(_inventory: Inventory):
  for i in get_data():
    var item= Inventory.Item.new()
    item.id= i.id
    item.item_type= i.item_type
    item.icon= load(i.icon)
    item.item_name= i.item_name
    item.cost= i.cost
    item.worth= i.worth
    _inventory.items.push_back(item)

func get_items():
  return container.get_children()
 
  
func initiate_selection():
  if get_items().is_empty():
    return
  list= GridListItem.new(self)
  list.items= get_items()
  list.column= 6
  list.index_max= get_items().size()-1
  list.selected_changed= func(n, a):
    selected= n
    for i in a:
      if i:
        i.toggle_active(false)
    n.toggle_active(true)
  
  list.selected= func(s):
    event_item_selected(s)
    
  list.is_active= true
  list.set_index_active(1)
  list.is_started_selecting= true

func event_item_used(item: Inventory.Item):
  #print(item.id==GameState.item_correct_id)
  var is_item_used_correct= func() -> bool:
    return item.id== GameState.item_correct_id
  print('used item id ', item.id)
  if is_item_used_correct.call():
    event_item_used_correct(item)
  else:
    event_item_used_wrong(item)

func event_item_used_correct(item: Inventory.Item):
  GameState.is_last_item_correct= true

  event_item_dropped(item)
  Mediator.air(Mediator.ITEM_USED_CORRECT)

func event_item_used_wrong(item: Inventory.Item):
  Mediator.air(Mediator.ITEM_USED_WRONG)
  
  print('item used wrong.')
  
  
func event_item_dropped(item: Inventory.Item):
  erase_current_item()
  DB.erase_inventory_item(item.id)

  
func event_item_gave(item: Inventory.Item):
  #print(item.id==GameState.item_correct_id)
  var is_item_used_correct= func() -> bool:
    return item.id== GameState.item_correct_id
  
  if is_item_used_correct.call():
    event_item_used_correct(item)
  else:
    event_item_used_wrong(item)
  
  
func event_item_selected(s):
  s.toggle_selection(true)
  list.toggle_input(false)
  s._on_nothing= func():
    list.toggle_input(true)
    s.toggle_selection(false)
  
  match GameState.item_state:
    GameState.ItemState.CAN_USE:
      s.set_action_text('USE')
      s._on_action= func():
        list.toggle_input(true)
        s.toggle_selection(false)
        event_item_used(s.get_meta(META_ITEM))
    GameState.ItemState.CAN_DROP:
      s.set_action_text('DROP')
      s._on_action= func():
        list.toggle_input(true)
        s.toggle_selection(false)
        event_item_dropped(s.get_meta(META_ITEM))
    GameState.ItemState.CAN_GIVE:
      s._on_action= func():
        list.toggle_input(true)
        s.toggle_selection(false)
        event_item_gave(s.get_meta(META_ITEM))
      s.set_action_text('GIVE')

func erase_current_item():
  selected.free()
  list.index_max-= 1
  if list.index_active== 1:
    list.index_active= 0
  else:
    list.index_active-= 1
  current_slot-= 1
  set_slot(current_slot)
  if get_items().is_empty():
    list.queue_free()
    return
  list.items= get_items()
  #list.last_selected_child= null
  #list.is_started_selecting= false
  list.set_index_active(0)
  #print(list.items)
  
@onready var slot: Label = %slot
func set_slot(_slot: int) -> void:
  current_slot= _slot
  slot.text= ' Slot {current_slot}/{max_slot}'.format({
    'current_slot': str(_slot),
    'max_slot':  str(get_max_slot()),
  })

func get_max_slot() -> int:
  return GameState.INVENTORY_MAX
  
func close():
  if list:
    list.free()
  for i in get_items():
    i.free()
    
func get_data():
  return DB.inventory_items
