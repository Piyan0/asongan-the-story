extends Node
class_name EventsID


# Note, when asigning enum in editor, the value would always the same,
#for example, if i set in editor the value MAIN_ROAD_001 ( currently 0 ), the editor will always have value 0,
#even tough we change MAIN_ROAD_001. Also, I need to restart the editor for it to update the enum if the enum is changed.

#so I can't add new value in the middle of value, for example I have MAIN_ROAD_001, MAIN_ROAD_002, I cannot
#add MAIN_ROAD_003 in the middle of it, since it will break the compatibilty, therefore, I add it below MAIN_ROAD_002.

#and note that I add =50 at SHOP_001, so when I add new entry in MAIN_ROAD_, the starting of SHOP_ won't change.
#just make sure that the event in each room/scene won't exceed 50, if it is, consider changing to bigger gap, i.e 100.
enum ID{
  MAIN_ROAD_001=0,
  MAIN_ROAD_002,
  MAIN_ROAD_003,
  MAIN_ROAD_004,
  MAIN_ROAD_005,
  MAIN_ROAD_006,
  MAIN_ROAD_007,

  SHOP_001=50,
  SHOP_002,
  SHOP_003,
  SHOP_004,
  SHOP_005,
}
