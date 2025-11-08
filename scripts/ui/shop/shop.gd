extends Node
class_name Shop

var _is_coin_enough: Callable = func(_cost: int) -> bool: return true
var _on_item_buyed: Callable = func(_item: ShopItem) -> void: pass
var _on_coin_not_enough: Callable = func() -> void: pass
var _on_no_stock: Callable = func() -> void: pass
var _inventory_full: Callable = func() -> void: pass
var _is_inventory_full: Callable = func() -> bool: return false

class ShopItem:
  var id: int
  var is_available: bool
  var owned: int
  var stock: int
  var item: Inventory.Item
 
var items: Array[ShopItem]

func buy_item(item: ShopItem) -> void:
  if not is_stock_available(item):
    _on_no_stock.call()
    return
  if _is_inventory_full.call():
    _inventory_full.call()
    return
  if _is_coin_enough.call(item.item.cost):
    erase_item(item)
    add_owned(item)
    _on_item_buyed.call(item)
    if item.item.item_type == DB.ItemType.UPGRADE:
      DB.upgrade_callback(
        item.item.id
      )
  else:
    _on_coin_not_enough.call()

func erase_item(item: ShopItem):
  var current_stock = item.stock
  current_stock -= 1
  if current_stock <= 0:
    current_stock = 0
  item.stock = current_stock

func add_owned(item: ShopItem):
  item.owned += 1
  
func is_stock_available(item: ShopItem) -> bool:
  return get_item_by_id(item.id).stock > 0
  
func get_item_by_id(id: int) -> ShopItem:
  for i in items:
    if i.id == id:
      return i
  
  return null
  
func get_items() -> Array[ShopItem]:
  return items
