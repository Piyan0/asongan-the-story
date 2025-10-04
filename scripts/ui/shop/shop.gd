extends Node
class_name Shop

var _is_coin_enough: Callable= func(cost: int)-> bool: return true
var _item_buyed: Callable= func(item: ShopItem) -> void: pass
var _coin_not_enough: Callable= func() -> void: pass
var _no_stock: Callable= func() -> void: pass
class ShopItem:
  var stock: int
  var id: int
  var item_name: String
  var cost: int
  var owned: int
  var is_available: bool
  
  func properties() -> Array[String]:
    return [
    'stock', 'id', 'item_name', 'cost',
    'owned', 'is_available'
    ]
 
var items: Array[ShopItem]

func buy_item(item: ShopItem) -> void:
  if not is_stock_available(item):
    _no_stock.call()
    return
  if _is_coin_enough.call(item.cost):
    erase_item(item)
    add_owned(item)
    _item_buyed.call(item)
  else:
    _coin_not_enough.call()

func erase_item(item: ShopItem):
  var current_stock= item.stock
  current_stock-= 1
  if current_stock<= 0:
    current_stock= 0
  item.stock= current_stock

func add_owned(item: ShopItem):
  item.owned+= 1
  
func is_stock_available(item: ShopItem) -> bool:
  return get_item_by_id(item.id).stock > 0
  
func get_item_by_id(id: int) -> ShopItem:
  for i in items:
    if i.id== id:
      return i
  
  return null
  
func get_items() -> Array[ShopItem]:
  return items
