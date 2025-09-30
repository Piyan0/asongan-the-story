extends Node2D

static var x: Dictionary= {
  'test':
    {
      'anjay':
        {'salwa': 'piyan'}
    }
}

func _ready() -> void:
  await get_tree().create_timer(1).timeout
  Saveable.save_to_json()
