extends Node
func _1(data, g: GameEvent):
  if not Car.current_car.is_buying[data.call().id]:
    return
  GameState.item_correct_id= data.call().expected_item
  print('item correct set to ', data.call().expected_item)
  GameState.item_state= GameState.ItemState.CAN_USE
  await OverlayManager.show_overlay(
    OverlayManager.Overlay.INVENTORY
  )
  if GameState.get_item_status():
    Sound.play(Sound.SFX.UI_TRANSACTION)
    var car= Car.current_car
    car.show_thanks()
    car.hide_hint(data.call().id)
    car.set_is_buying(data.call().id, false)
    if CarScene.is_phase_selling_done():
      GameState.is_buyer_fulfilled= true
      
    var item= DB.get_item(data.call().expected_item)
    g.add_coin(item.worth)
  else:
    print('wrong.')
  GameState.item_state= GameState.ItemState.CAN_DROP
  GameState.item_correct_id= -1
