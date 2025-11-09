extends Node

func _1(data_callb: Callable, g:GameEvent) -> void:
  var data : CommonDialogueData= data_callb.call()
  for i in data.dialogue_string:
    await TextBubble.show_text(
      data.dialogue_id, i
    )
    await Mediator.get_tree().create_timer(0.2).timeout
