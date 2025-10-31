extends Node
class_name ReparentChild


func migrate(parent_target: Node, parent_source: Node) -> void:
    for i in parent_source.get_children():
      i.reparent(parent_target)
    
    
    
