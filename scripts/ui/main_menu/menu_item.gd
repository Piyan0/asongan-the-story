extends Label
class_name MenuItem

var callback: Callable= func(): pass

func set_callback(_callback: Callable):
  callback= _callback

func get_callback():
  return callback
