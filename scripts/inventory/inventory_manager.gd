extends Node
class_name InventoryManager


class Item:
  var icon: String
  var item_name: String
  var item_id: String
  var is_equipped: bool = false
  var is_in_inventory: bool= true
  var can_thrown: bool= true
  
  static func properties() -> Array[String]:
    return [
    'icon',
    'item_name',
    'item_id',
    'is_equipped',
    'is_in_inventory',
    'can_thrown', 
]
  
  
signal item_equip_toggle(item: ItemData)

@export var items_res: Array[ItemData]

var item_correct_callback: Callable
var item_id_correct: String
#SAVE
var items: Array[Item]
var max_slot: int= 10
var equipped: int= 0
var max_equipped: int= 0

var list_selection: HorizontalListItem
var is_shown: bool= false
static var instance: InventoryManager
var child_instance : Inventory

func _ready() -> void:
  add_item(items_res[1])
  add_item(items_res[2])
  add_item(items_res[3])
  add_item(items_res[3])
  
  if not instance:
    instance= self
  
  await get_tree().process_frame
  child_instance= get_tree().get_first_node_in_group('Inventory')
  
  close_inventory()

static func item_from_res(res: ItemData) -> Item:
  var item= Item.new()
  item.icon= res.icon.resource_path
  item.item_name= res.item_name
  item.item_id= res.item_id
  item.can_thrown= res.can_thrown
  item.is_equipped= res.is_equipped
  item.is_in_inventory= res.is_in_inventory
  return item
  
func add_item(res: ItemData) -> void:
  items.push_back(item_from_res(res))
  
func is_equipped_full() -> bool:
  return equipped >= max_equipped

func get_in_inventory_items() -> Array[Item]:
  var in_inventory: Array[Item]
  for i: Item in items:
    if i.is_in_inventory:
      in_inventory.push_back(i)
  
  return in_inventory
    
func display_inventory() -> void:
  max_equipped= OnHoldItemsManager.instance.get_max_slot()
  child_instance.show()
  set_process_input(true)
  var items_slot : Array[InventoryItem] = child_instance.get_item_slot()
  var items_slot_active: Array
  for i in items_slot:
    i.in_slot(false)
    i.is_holding_item= false
    i.set_texture(CompressedTexture2D.new())
    i.hide()
  
  for i in max_slot:
    items_slot[i].show()
    items_slot_active.push_back(items_slot[i])
  
  var data: Array[Item]= get_in_inventory_items()
  for i in get_in_inventory_items().size():
    var item: InventoryItem= items_slot[i]
    item.is_holding_item= true
    if items[i].is_equipped:
      item.in_slot(true)
    item.show.call_deferred()
    item.set_texture(load(items[i].icon))

  initiate_selection(items_slot_active, max_slot-1)
  child_instance.update_status(equipped, max_equipped)

func toggle() -> void:
  is_shown =! is_shown
  if is_shown:
    display_inventory()
  else:
    close_inventory()
  
func initiate_selection(_items, max: int) -> void:

  list_selection= HorizontalListItem.new(self)
  list_selection.items= _items
  list_selection.index_max= max
  
  list_selection.selected_changed = (func(new : InventoryItem, all):
    for i:InventoryItem in all:
      i.blip(false)
      i.blip_animation(true)
    new.blip(true)
    new.blip_animation(false)
      
    )
  list_selection.freed= func(all):
    for i: InventoryItem in all:
      i.blip(false)
      
func close_inventory() -> void:
  set_process_input(false)
  if list_selection:
    list_selection.release()
    list_selection.free()
    
  child_instance.hide()
    
func on_item_equip_toggle(item: Item):
  
  var last_item_selected: InventoryItem= list_selection.get_selected()
  if not last_item_selected:
    return
  
  if item.is_equipped:
    equipped-= 1
    last_item_selected.in_slot(false)
    item.is_equipped= false
    child_instance.update_status(equipped, max_equipped)
  
  else:
    if not is_equipped_full():
      equipped+= 1
      item.is_equipped= true
      last_item_selected.in_slot(true)
      child_instance.update_status(equipped, max_equipped)

func delete_item(item: Item) -> void:
  equipped-= 1
  items.erase(item)

func is_used_item_correct(item_id: String) -> bool:
  return item_id== item_id_correct
  
func get_items() -> Array:
  return items

func set_callable(call: Callable):
  item_correct_callback= call

func get_callable():
  return item_correct_callback 

func reset_item_status():
  item_id_correct= ''
  item_correct_callback= func(): pass
func set_item_id_correct(id: String):
  item_id_correct= id
  
func _input(event: InputEvent) -> void:
  if not list_selection: return
  if event.is_action_pressed('z'):
    var item_selected: InventoryItem= list_selection.last_selected_child
    if not item_selected: return
    if item_selected.is_holding_item:
      on_item_equip_toggle(items[list_selection.index_active])
  
  #if event.is_action_pressed("ui_accept"):
    #delete_item('tofu')
    #display_inventory()
      #
  #if event.is_action_pressed("ui_accept"):
    #add_item(load('res://scripts/inventory/item_db/tofu.tres'))
    #display_inventory()
