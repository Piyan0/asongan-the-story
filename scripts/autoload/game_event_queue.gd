extends Node

var queue: Array[Callable] = [
  
  #func():
    #Mediator.air(
      #Mediator.TRAIN_TIMER_START, [6, func():
        #GameState.change_car_batch(CarsBatch.Batch.STAGE_1_001)
        #]
    #),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [3, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_1_002)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_1_003)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_1_004)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_1_005)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_1_006)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_001)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_002)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_003)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_004)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_005)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_006)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_007)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_3_001)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_3_002)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_3_003)
        ]
    ),
  func():
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_3_004)
        ]
    ),
  
  func():
    print('anjay.')
]

func pop():
  var callable = queue.pop_front()
  callable.call()
