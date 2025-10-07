extends CanvasLayer
@onready var money: Label = $Control/money
@onready var train: Label = $Control2/train

func set_money(_money: int) -> void:
  money.text= 'Rp. '+NumberDotted.parse(_money)

func set_train_arrival(minutes: int, second: int) -> void:
  train.text= '{minutes}:{second}'.format({
    'minutes': minutes,
    'second': second,
  })
