extends Node

var queue: Array[Callable] = [
 
  func():
    DB.set_stock_based_on_foods([FoodPackOfTofu.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [6, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_1_001)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodTofuWithRiceRoll.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_1_002)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodPackOfTofu.new(), FoodTofuWithRiceRoll.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_1_003)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodTofuWithRiceRoll.new(), FoodTofuWithRiceRoll.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_1_004)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodPackOfTofu.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_1_005)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodPackOfTofu.new(), FoodTofuWithRiceRoll.new(), FoodTofuWithRiceRoll.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_1_006)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_001)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodPackOfTofu.new(), FoodTofuWithRiceRoll.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_002)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodCoffe.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_003)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodCoffe.new(), FoodPackOfTofu.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_004)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodPackOfTofu.new(), FoodPackOfTofu.new(), FoodCoffe.new(), FoodTofuWithRiceRoll.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_005)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodCoffe.new(), FoodTofuWithRiceRoll.new(), FoodPackOfTofu.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_006)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodTofuWithRiceRoll.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_2_007)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodCoffe.new(), FoodTofuWithRiceRoll.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_3_001)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodTofuWithRiceRoll.new(), FoodPackOfTofu.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_3_002)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodCoffe.new(), FoodPackOfTofu.new()])
    Mediator.air(
      Mediator.TRAIN_TIMER_START, [30, func():
        GameState.change_car_batch(CarsBatch.Batch.STAGE_3_003)
        ]
    ),
  func():
    DB.set_stock_based_on_foods([FoodTofuWithRiceRoll.new()])
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
