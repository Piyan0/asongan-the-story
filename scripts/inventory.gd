class_name Inventory

class Item:
  var id: int
  var item_type: DB.ItemType
  var icon: Texture2D
  var item_name: String
  var cost: int
  var worth: int

var items: Array[Item]
