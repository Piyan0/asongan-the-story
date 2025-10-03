extends Node
class_name MultipleVerticalList

class VerticalList:
  var id: int
  var vertical: VerticalListItem

var lists: Array[VerticalList]

func add_list(id: int, list: VerticalListItem):
  var _list= VerticalList.new()
  _list.id= id
  _list.vertical= list
  #print(list)
  lists.push_back(_list)

func change_focus(id: int):
  for i in lists:
    #print(i.vertical)
    if i.id== id:
      i.vertical.toggle_input(true)
      continue
    i.vertical.toggle_input(false)
    
func initial_active(id: int):
  change_focus(id)
