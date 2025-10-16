extends Control
class_name ChoiceSelect

signal selected

var color_passive= Color('8c7c79')
var color_active= Color('292326')
var list: VerticalListItem
var selected_options= -1
static var instance: ChoiceSelect

func _ready() -> void:
  if not instance:
    instance= self
  if is_main():
    initiate_selection(['Salwa.', 'Hawa.'])
  
    await selected
    if get_selected()== 0:
      print('salwa')
    elif get_selected()== 1:
      print('hawa')
  else:
    hide()


func is_main():
  return get_tree().current_scene== self
  
  
func initiate_selection(opt_text= ['Yes.', 'No.']):
  list= VerticalListItem.new(self)
  list.items= selection_label()
  selection_label()[0].set_meta('id', 0)
  selection_label()[1].set_meta('id', 1)
  selection_label()[0].text= opt_text[0]
  selection_label()[1].text= opt_text[1]
  list.index_max= 1
  list.selected_changed= func(s, a):
    for i in a:
      i.modulate= color_passive
    s.modulate= color_active
  
  list.selected= func(s):
    selected_options= s.get_meta('id')
    print(selected_options)
    selected.emit()
  
  list.is_active= true
  list.set_index_active(1)
  list.is_started_selecting= true


func get_selected() -> int:
  var _temp= selected_options
  return _temp
  
  
func end_selection():
  selected_options= -1
  if list:
    list.queue_free()
    
    
func selection_label() -> Array[Label]:
  return [
    $buy_hint/Label, $buy_hint/Label2
  ]
