extends Control
class_name ShopItemUI

@onready var label: Label = $Label
@onready var stock: Label = $stock
@onready var owned: Label = $owned
@onready var cost: Label = $cost

func set_text(t: String):
  label.text= t

func set_stock(_stock: String):
  stock.text= _stock

func set_cost(_cost: String):
  cost.text= _cost
  
func set_owned(_owned: String):
  owned.text= _owned
  
func toggle_active(is_on: bool):
  if is_on:
    $ColorRect.show()
  else:
    $ColorRect.hide()
  
