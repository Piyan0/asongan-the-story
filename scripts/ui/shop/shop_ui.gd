extends Control
@onready var container: VBoxContainer = $container

class Result:
  var item_boughted: Array[Shop.ShopItem]
  var coin_used: int
  
var shop: Shop
var list: VerticalListItem

var shop_item_ui: PackedScene
var selected_item_ui: ShopItemUI

const META_ITEM= 'q'

var current_coin: int
var result: Result

func _ready() -> void:

  shop_item_ui= load("res://scenes/ui/shop/shop_item.tscn") 
  display_items()
  
func initiate_shop():
  shop= Shop.new()
  shop._no_stock= on_no_stock
  shop._item_buyed= on_item_buyed
  shop._is_coin_enough= is_coin_enough
  shop._coin_not_enough= on_coin_not_enough
  
  fill(shop)
  
  
func display_items() -> void:
  
  initiate_shop()
  
  var items: Array[Shop.ShopItem]= shop.get_items()
  result= Result.new()
  current_coin= get_coin()
  set_coin(current_coin)
  
  for i in items:
    var _shop_item_ui: ShopItemUI= shop_item_ui.instantiate()
    _shop_item_ui.set_meta(META_ITEM, i)
    container.add_child(_shop_item_ui)
    _shop_item_ui.set_text(i.item_name)
    _shop_item_ui.set_owned(i.owned)
    _shop_item_ui.set_stock(i.stock)
    _shop_item_ui.set_cost(i.cost)
  
  initiate_selection()

func get_items_ui():
  return container.get_children()
  
func initiate_selection():
  list= VerticalListItem.new(self)
  list.items= get_items_ui()
  list.index_max= get_items_ui().size()-1
  
  list.selected_changed= func(n, a):
    for i in a:
      i.toggle_active(false)
      
    n.toggle_active(true)
    selected_item_ui= n
  
  list.selected= func(n):
   on_try_to_buy(n.get_meta(META_ITEM))
  
  list.is_active= true

func is_coin_enough(cost: int):
  return current_coin>= cost
 
func on_coin_not_enough():
  print('Coin is not enough.') 
  
func on_try_to_buy(item: Shop.ShopItem):
  shop.buy_item(item)

func on_item_buyed(item: Shop.ShopItem):
  
  result.coin_used+= item.stock
  result.item_boughted.push_back(item)
  
  print('{item_name} stock is currently at {stock}'.format({
    item_name= item.item_name,
    stock= item.stock
  }))
  selected_item_ui.set_stock(item.stock)
  selected_item_ui.set_owned(item.owned)
  current_coin-= item.cost
  set_coin(current_coin)
  
func on_no_stock():
  print('No stock...')
  
@onready var coin: Label = $coin

func set_coin(_coin: int):
  coin.text= str(_coin)
  
func fill(_shop: Shop):
  for i in DB.shop_items:
    var item= Shop.ShopItem.new()
    item.stock = DB.shop_items[i].stock 
    item.id = i
    item.item_name = DB.shop_items[i].item_name
    item.cost = DB.shop_items[i].cost
    item.owned = DB.shop_items[i].owned
    item.is_available = DB.shop_items[i].is_available
    shop.items.push_back(item)

func is_need_fill() -> bool:
  return true

func get_result() -> Result:
  return result

func get_coin() -> int:
  return 990
