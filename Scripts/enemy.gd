extends BaseEntity
class_name Enemy

var player : Player

func _ready() -> void:
	damage = 20
	speed = 100
	sprite = $sprite

func _process(delta: float) -> void:
	animation(direction)

func setup(_player : Player) -> void:
	player = _player

func setDirection() -> void:
	moving = false
	if player != null:
		direction = position.direction_to(player.position)
		moving = true

func isRival (area : Area2D) -> bool:
	return super.isRival(area) and area.get_parent() is Player
