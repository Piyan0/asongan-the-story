extends Node
class_name OnHoldItemsManager
signal item_used(item: InventoryManager.Item)
signal item_thrown(item: InventoryManager.Item)

static var instance: OnHoldItemsManager
var child_instance: OnHoldItems
var is_shown: bool= false
var list_selection: HorizontalListItem
var is_will_throw_item: bool= false
var max_slot: int= 2

func _ready():
  if not instance:
    instance= self
  
  await get_tree().process_frame
  child_instance= get_tree().get_first_node_in_group('OnHoldItems')
  
  await get_tree().create_timer(0.2).timeout
  
  close_inventory()
  #display_inventory()

#test
#func get_equipped_data() -> Array:
 #
  #var equipped_item: Array = [
    ##InventoryManager.instance.item_from_res(load("res://scripts/inventory/item_db/coffe.tres")),
    #InventoryManager.instance.item_from_res(load("res://scripts/inventory/item_db/tofu.tres")),
    #InventoryManager.instance.item_from_res(load("res://scripts/inventory/item_db/coffe.tres")),
  #]
  #
  #for i in equipped_item:
    #i.is_equipped= true
  #
  #return equipped_item

func get_equipped_data() -> Array:
  var datas= InventoryManager.instance.items
  var equipped_item: Array
  for i in datas:
    if i.is_equipped:
      equipped_item.push_back(i)
  return equipped_item
  
func get_max_slot():
  return max_slot
func display_inventory():
  set_process_input(true)
  is_shown= true
  child_instance.show()
  var datas: Array= get_equipped_data()
  var slots: Array[ItemSlot]= child_instance.get_items()
  for i:ItemSlot in slots:
    i.hide()
    i.set_meta('data', '')
    i.set_icon(CompressedTexture2D.new())
    i.is_has_item= false
  
  for i in max_slot:
    slots[i].show()
    
  for i in datas.size():
    var slot= slots[i]
    var data= datas[i]
    slot.is_has_item= true
    slot.set_meta('data', data)
    slot.set_icon(load(data.icon))
    
  initiate_selection(slots)

func close_inventory():
  is_shown= false
  if list_selection:
    list_selection.release()
    list_selection.free()
  child_instance.hide()
  set_process_input(false)

func toggle():
  is_shown= !is_shown
  if is_shown:
    display_inventory()
  else:
    close_inventory()

func initiate_selection(items: Array):
  if list_selection:
    list_selection.free()
    
  list_selection= HorizontalListItem.new(self)
  list_selection.index_max= max_slot-1
  list_selection.items= items
  
  list_selection._can_select= func():
    return child_instance.is_all_slots_idle()
  
  list_selection.selected_changed= func(new, all):
    
    for i: ItemSlot in all:
      if i== new:
        continue
      await i.inactive()
      
    await new.active()
    
  list_selection.freed= func(all):
    for i in all:
      i.inactive()
 
func on_item_used(item_data: InventoryManager.Item):
  item_used.emit(item_data)
 
func on_item_thrown(item_data: InventoryManager.Item):
  item_thrown.emit(item_data)

func use_item(slot: ItemSlot):
  slot.set_icon(CompressedTexture2D.new())
  slot.is_has_item= false
  slot.set_meta('data', '')

func use_current_item():
  use_item(list_selection.last_selected_child)

func set_use_mode(_is_will_throw_item: bool):
  is_will_throw_item= _is_will_throw_item
  
  
func _input(event: InputEvent) -> void:
  if not list_selection: return
  if child_instance:
    if not child_instance.is_all_slots_idle(): return
  
  
  if event.is_action_pressed('z') and list_selection.is_started_selecting:
    if list_selection.last_selected_child.is_has_item:
      if is_will_throw_item:
        on_item_thrown(list_selection.last_selected_child.get_meta('data'))
      else:
        on_item_used(list_selection.last_selected_child.get_meta('data'))
  #if event.is_action_pressed('ui_accept'):
    #close_inventory()
  #if event.is_action_pressed("ui_down"):
    #display_inventory()

  
  
  
