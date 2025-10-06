class_name NumberDotted

enum {
  THOUSANDS,
  TEN_OF_THOUSANDS,
  HUNDRED_OF_THOUSANDS,
  MILLIONS,
  TENS_OF_MILLIONS,
}

static var insert_location= {
  THOUSANDS: [1],
  TEN_OF_THOUSANDS: [2],
  HUNDRED_OF_THOUSANDS: [3],
  MILLIONS: [1, 4],
  TENS_OF_MILLIONS: [2, 5]
}

static func parse(num: int, dot='.') -> String:
  var str_num= str(num)
  var result= str_num
  var array_num= str_num.split('')
  var type: int= get_number_type(num)
  if type== -1:
    #print(1)
    return result
    
  var inserted= 0
  for i in insert_location[type]:
    array_num.insert(i+ inserted, dot)
    inserted+= 1
  
  result= ''.join(array_num)
  return result
        


static func get_number_type(num: int) -> int:
  var str_num= str(num)
  print(str_num.length())
  if str_num.length() < 4:
    return -1
  
  match str_num.length():
    4:
      return THOUSANDS
    5:
      return TEN_OF_THOUSANDS
    6:
      return HUNDRED_OF_THOUSANDS
    7:
      return MILLIONS
    8:
      return TENS_OF_MILLIONS
  
  return -1
