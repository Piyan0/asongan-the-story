extends Control
class_name ShopItemUI

@onready var label: Label = $Label
@onready var stock: Label = $stock
@onready var owned: Label = $owned
@onready var cost: Label = $cost

func set_text(t: String):
  label.text= t

func set_stock(_stock: int):
  stock.text= str(_stock)

func set_cost(_cost: int):
  cost.text= str(_cost)
  
func set_owned(_owned: int):
  owned.text= str(_owned)
  
func toggle_active(is_on: bool):
  if is_on:
    $ColorRect.show()
  else:
    $ColorRect.hide()
  
