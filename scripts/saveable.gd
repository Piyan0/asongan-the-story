extends Node
class_name Saveable

#DEV
const SAVE_PATH := 'res://save.json'
static var class_map: Dictionary = {
  #'InventoryManager': InventoryManager,
  'ControlHint': ControlHint,
  'EventManager': EventManager,
  'Cooking': Cooking,
}
static var SAVE_ABLE_PLAIN : Array=[
 
  ['InventoryManager', 'instance.max_slot'],
  ['InventoryManager', 'instance.equipped'],
  ['InventoryManager', 'instance.max_equipped'],
  ['ControlHint', 'instance.data'],
  ['ControlHint', 'instance.prev_data'],
  
]
#This must be an array of class, 'items' is referring to Array of Item.
#[2] is a base class of instance
static var SAVE_ABLE_ARRAY_OF_CLASS: Array= [
   #['InventoryManager', 'instance.items', InventoryManager.Item],
   ['EventManager', 'instance.queue_autostart', EventManager.Autostart],
   ['Cooking', 'ingredients_owned', CookingIngredient]
]

  
static func save_to_json():
  var save: Array
  for i in SAVE_ABLE_PLAIN:
    var source: String= i[0]
    var props: String= i[1]
    var value_to_save: Variant = traverse_json(get_base_class_from_string(source), props)
    var dict_to_save: Dictionary= {
      'from_class': source,
      'props': props,
      'value': value_to_save
    }
    save.push_back(dict_to_save)
  
    
  
  for i in SAVE_ABLE_ARRAY_OF_CLASS:
    var source: String= i[0]
    var props: String= i[1]
    var base_class = i[2]
    
    var clasess: Array[Dictionary]
    
    for j: Object in traverse_json(get_base_class_from_string(source), props):
      #print(j)
      var class_dict: Dictionary= class_to_json(base_class, j)
      clasess.push_back(class_dict)
    
    var dict_to_save: Dictionary= {
      'from_class': source,
      'props': props,
      'value': clasess
    }
    
    save.push_back(dict_to_save)
    
  print_json(save)


 
static func traverse_json(dictionary: Variant, props_separated_by_dots: String) -> Variant:
  #print(dictionary, props_separated_by_dots)
  var parsed_props: Array= props_separated_by_dots.split('.')
  
  var current_inner_child: Variant
  current_inner_child= dictionary
  for i in parsed_props:
    current_inner_child= current_inner_child[i]
  
  return current_inner_child


static func set_inner_json(dictionary: Variant, props_separated_by_dots: String, value: Variant) -> void:
  var parsed_props: Array= props_separated_by_dots.split('.')
  var last_el: String= parsed_props.pop_back()
  
  var current_inner_child: Variant
  current_inner_child= dictionary
  for i in parsed_props:
    current_inner_child= current_inner_child[i]
  
  current_inner_child[last_el]= value


static func class_to_json(base_class: GDScript, instance: Object) -> Dictionary:
  var data: Dictionary
  var props: Array[String]= base_class.properties()
  for i in props:
    data[i]= instance[i]
  return data

static func json_to_class(base_class: GDScript, json):
  var props : Array[String]= base_class.properties()
  var instance= base_class.new()
  for i in props:
    instance[i]= json[i]
  
  return instance
  
static func get_base_class_from_string(id: String) -> GDScript:
  for i in class_map:
    var _id: String= i
    #print(id)
    if _id== id:
      #print(class_map[i])
      return class_map[i]
  
  #print(1)
  return null

static func print_json(dict: Variant) -> void:
  var string= JSON.stringify(dict, '  ')
  print(string)

static var data_to_save: Dictionary
static func set_data(id: String, value) -> void:
  data_to_save[id] = value

static func get_data(id: String) -> Variant:
  return data_to_save[id]

static func has_key(id: String) -> bool:
  return id in data_to_save
  
static func save_to_file(path= SAVE_PATH) -> void:
  var file= FileAccess.open(path, FileAccess.WRITE)
  file.store_string(
    JSON.stringify(data_to_save)
  )
  file.close()

static func load_from_file(path= SAVE_PATH) -> void:
  if not FileAccess.file_exists(path):
    return
  var file= FileAccess.open(path, FileAccess.READ)
  var data= JSON.parse_string( file.get_as_text() )
  data_to_save= data
  
static func string_keys_to_int(dict: Dictionary) -> Dictionary:
  var data: Dictionary
  for i in dict:
    var key= int(i)
    data[key]= dict[i]
  
  return data
