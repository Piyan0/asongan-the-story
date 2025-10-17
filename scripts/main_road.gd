extends Node2D

var row_1_stop= Vector2(74, CarScene.row_1)
var row_2_stop= Vector2(841, CarScene.row_2)

const car= Car.CarID
const templ= CarScene.SellTemplate

func _ready() -> void:
  #var x= DB.ingredients_from_shop()
  #for i in x:
    #print(DB.Ingredient.find_key(i._id()))
  
  var x: Array[CookingIngredient]= [
    IngredientWater.new(),
    IngredientCoffePowder.new(),
  ]
  var coffe= FoodCoffe.new()
  var tofu= FoodTofuWithRiceRoll.new()
  var foods: Array[CookingFood]= [coffe, tofu]
  print('>>',GameState.is_coin_enough_to_buy_one_of_foods(6, foods))
  var utils= CookingUtils.new([])
  print(
    utils.is_ingredients_enough(x, coffe),
  )
  limit_player()

  var arr : Array[Callable]= [
    move_car(car.CAR_001, car.CAR_FIRST_ROW, templ.TOFU_AND_EXTRA, 0),
    #move_car(car.CAR_002, car.CAR_001, templ.TOFU_AND_COFFE, 2),
    #move_car(car.CAR_003, car.CAR_002, templ.TOFU_AND_COFFE, 2*2),
    #move_car(car.CAR_005, car.CAR_003, templ.TOFU_AND_COFFE, 2*3),
    #move_car(car.CAR_008, car.CAR_005, templ.TOFU_AND_COFFE, 2*4),
    #move_car(car.CAR_006, car.CAR_008, templ.TOFU_AND_COFFE, 2*5),
    #
    #move_car(car.CAR_014, car.CAR_SECOND_ROW, templ.EMPTY, 2* 1),
    #move_car(car.CAR_013, car.CAR_014, templ.COFFE_ONLY, 2* 2),
    #move_car(car.CAR_016, car.CAR_013, templ.TOFU_AND_COFFE, 2* 4),
  ]
  
  Mediator.air(
    Mediator.CAR_BATCH,
    [
      arr, 5
    ]
  )
  
func limit_player():
  $player_limit.area_entered.connect(func(area):
    if area.name != 'player': return
    Player.player.position= Vector2(960, 150)
    OverlayManager.show_alert('PLAYER_LIMIT')
    )


# DEPENDENT cars_node
func get_cars():
  return [
    $car001, $car002, $car003, $car004, $car005, $car006, $car007, $car008, $car009, $car010, $car011, $car012, $car013, $car014, $car015, $car016
  ]


func get_cars_by_id(id: Car.CarID) -> Node2D:

  for i in get_cars():
    if i.car_id== id:
      return i
      
  return
  
    
func move_car(id: Car.CarID, position_id: int, sell_template: CarScene.SellTemplate, delay: float, ) -> Callable:
  var car= get_cars_by_id(id)
  var position_callable: Callable
  if position_id== -1:
    position_callable= func():
      return row_1_stop
  elif position_id== -2:
    position_callable= func():
      return row_2_stop
  else:
    position_callable= Car.get_back_point.bind(position_id)
  
  #print(position_callable.call())
  var sell_data: Array[CarScene.SellData]= CarScene.get_template(sell_template)
  
  return car.move_and_buy.bind(delay, position_callable, sell_data)


func is_ingredient_available():
  return true
  
  
func _process(delta: float) -> void:
  pass

    
