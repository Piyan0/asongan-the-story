extends Node
func _1(data, g: GameEvent):
  g.set_item_status(data.expected_item, func():
    await g.add_coin(3000)
    )

  
func _1_after(data, g: GameEvent):
  g.reset_item_status()
  
