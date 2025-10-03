extends Node
class_name Pika

const TRANSLATION_KEYS= 0
const LANGUAGE_INA= 1
const LANGUAGE_EN= 2

var data: Array= []
#SAVE
static var lang= LANGUAGE_EN

var reactives: Array[Label]

func load_csv(path):
  var r= []
  var file= FileAccess.open(path, FileAccess.READ)
  while !file.eof_reached():
    var csv= file.get_csv_line()
    #prevent empty csv.
    if csv.size()<3:
      continue
    r.push_back(csv)
  
  data= r
  
  #print(data)
  
  
func translate(key: String):
  for i in data:
    if i[ TRANSLATION_KEYS ]== key:
      #print(key)
      return i[lang]
  print('no match translation ')

func translate_by_value(value: String):
  var key: String
  for i in data:
    #printt(i[LANGUAGE_EN], i[LANGUAGE_INA], i)
    if i[LANGUAGE_EN]== value or i[LANGUAGE_INA]== value:
      key= i[TRANSLATION_KEYS]
  return translate(key)

func set_lang(_lang: int):
  lang= _lang

func translate_by_content() -> void:
  #print(1)
  for i in reactives:
    #print(i.text)
    var tr= translate_by_value(i.text)
    if tr== null:
      push_error('Translation not found of %s' % i.text)
      continue
    i.text= (
      tr
    )
