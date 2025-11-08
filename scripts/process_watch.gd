extends Node
class_name ProcessWatch

var callb: Callable
var stop_watching: bool= false

func is_condition_met(conds: Array[bool]) -> bool:
  return conds.all(func(n): return n)

func tick(conds: Array[bool]) -> void:
  if stop_watching:
    return
    
  if is_condition_met(conds):
    #stop_watching= true
    exec()

func set_active() -> void:
  stop_watching= false
  
func exec():
  callb.call()
    
  
