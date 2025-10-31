extends Node2D

static var x: Dictionary= {
  'test':
    {
      'anjay':
        {'salwa': 'piyan'}
    }
}

func _ready() -> void:
  var y = ReparentChild.new()
  y.migrate(
    self, $Node
  )
