extends Node

var queue: Array[Callable]=[]

func pop():
  var callable= queue.pop_front()
  callable.call()
