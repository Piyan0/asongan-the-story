extends Node
class_name MultipleOptionsSelection

var options_selections: Dictionary
var current_focused_options_id: int

func pause_focus():
  for i in options_selections:
    options_selections[i].is_active= false

func resume_focus():
  change_focus(current_focused_options_id)
  
func change_focus(id: int):
  current_focused_options_id= id
  for i in options_selections:
    #printt(1, i)
    if i== id:
      options_selections[i].is_active= true
      continue
      
    #print(options_selections[i])
    options_selections[i].is_active= false

func add_selection(id: int, option: OptionsSelection):
  var dict: Dictionary
  dict[id]= option
  options_selections.merge(dict)
  
