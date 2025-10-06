class_name Inventory

class Item:
  var id: int
  var item_type: DB.ItemType
  var icon: Texture2D
  var item_name: String
  var cost: int
  var worth: int

var items: Array[Item]

static func item_from_data(data) -> Item:
  var item= Item.new()
  item.id= data.id
  item.item_type= data.item_type
  item.icon= load(data.icon)
  item.item_name= data.item_name
  item.cost= data.cost
  item.worth= data.worth
  
  return item
