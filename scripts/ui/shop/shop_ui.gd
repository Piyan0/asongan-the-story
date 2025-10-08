extends Control
@onready var container: VBoxContainer = $container
  
var shop: Shop
var list: VerticalListItem

var shop_item_ui: PackedScene
var selected_item_ui: ShopItemUI

const META_ITEM= 'q'

var current_coin: int

func _ready() -> void:
  shop_item_ui= load("res://scenes/ui/shop/shop_item.tscn") 
  if get_tree().current_scene== self:
    display_items()


  
func initiate_shop():
  shop= Shop.new()
  shop._on_no_stock= event_no_stock
  shop._on_item_buyed= event_item_buyed
  shop._is_coin_enough= is_coin_enough
  shop._on_coin_not_enough= event_coin_not_enough
  
  fill(shop)
  
  
func display_items() -> void:
  
  initiate_shop()
  
  var items: Array[Shop.ShopItem]= shop.get_items()
  current_coin= get_coin()
  set_coin(current_coin)
  
  for i in items:
    #print(i.item.item_name)
    var _shop_item_ui: ShopItemUI= shop_item_ui.instantiate()
    _shop_item_ui.set_meta(META_ITEM, i)
    #print(_shop_item_ui.get_meta(META_ITEM).item_name)
    #print(1)
    container.add_child(_shop_item_ui)
    _shop_item_ui.set_item_name(i.item.item_name)
    _shop_item_ui.set_status(str(i.stock), str(i.owned))
    #print(i.item.cost)
    _shop_item_ui.set_cost(NumberDotted.parse(i.item.cost))
  
  initiate_selection()
  await get_tree().process_frame
  #HACK the x is reset it size when hided, doing this will...make it work.
  $container.size.x= $container.size.x
  $Control.size= $container.size

func is_idle():
  for i in get_items_ui():
    if not i.is_idle:
      return false
      
  return true
  
func get_items_ui():
  return container.get_children()
  
func initiate_selection():
  list= VerticalListItem.new(self)
  list.items= get_items_ui()
  list.index_max= get_items_ui().size()-1
  
  list._can_select= func():
    return is_idle()
    
  list.selected_changed= func(n, a):
    for i in a:
      if i.is_state_active:
        i.toggle_active(false)
        
    n.toggle_active(true)
    selected_item_ui= n
  
  list.selected= func(n):
    #print(n.get_meta(META_ITEM).item_name)
    on_try_to_buy(n.get_meta(META_ITEM))
  
  list.is_active= true

func is_coin_enough(cost: int):
  return current_coin>= cost
 
func event_coin_not_enough():
  print('Coin is not enough.') 
  
func on_try_to_buy(item: Shop.ShopItem):
  shop.buy_item(item)

func event_item_buyed(item: Shop.ShopItem):
  
  DB.set_item_shop(item.item.id, {
    'stock': item.stock,
    'owned': item.owned
  })
  
  DB.add_item_to_inventory(item.item.id)
  
  #print(DB.shop_items)
  
  print('{item_name} stock is currently at {stock}'.format({
    item_name= item.item.item_name,
    stock= item.stock
  }))
  
  selected_item_ui.set_status(str(item.stock), str(item.owned))
  #selected_item_ui.set_owned(str(item.owned))
  current_coin-= item.item.cost
  set_coin(current_coin)
  GameState.minus_coin(item.item.cost)
  
func event_no_stock():
  print('No stock...')
  
@onready var coin: Label = %coin



func set_coin(_coin: int):
  coin.text= ' RP. {value}'.format({
    'value': NumberDotted.parse(_coin)
  })
  
func fill(_shop: Shop):
  for i in DB.shop_items:
    var item= Shop.ShopItem.new()
    item.id= i.id
    item.is_available= i.is_available
    item.owned= i.owned
    item.stock= i.stock
    item.item= Inventory.item_from_data( DB.get_item(i.id) )
    _shop.items.push_back(item)

func is_need_fill() -> bool:
  return true
  
func get_coin() -> int:
  return GameState.current_coin

func close():
  if list:
    list.free()
  for i in get_items_ui():
    i.free()
    
#func _input(event: InputEvent) -> void:
  #if event.is_action_pressed("c"):
    #close()
    #await get_tree().create_timer(1).timeout
    #display_items()
  #get_result(true)
