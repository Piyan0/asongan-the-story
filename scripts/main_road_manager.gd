extends Node
class_name MainRoadManager

static var instance: MainRoadManager

func _ready() -> void:
  if not instance:
    instance= self
    
    if TrainStopping.instance:
      TrainStopping.instance.car_arrived.connect(on_TrainStopping_car_arrived)
  

func on_TrainStopping_car_arrived():
  #print(1)
  CarManager.instance.toggle_move(false)
  
func prepare_for_train():
  TrainStopping.instance.toggle_lever(true)
  CarManager.instance.batch_cars()
  await CarManager.instance.cars_stopped
  Train.instance.move_train(1)
  await Train.instance.train_leaved
  TrainStopping.instance.toggle_lever(false)
  await CarManager.instance.toggle_move(true)
  await CarManager.instance.cars_leaved
