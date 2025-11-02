extends CharacterBody2D
class_name Enemy

var player : Player
var SPEED : float = 200
var vida : float = 100
var damage : float  = 20

func _process(delta: float) -> void:
	velocity = position.direction_to(player.position) * SPEED
	move_and_slide()

func setup(_player : Player) -> void:
	player = _player


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group('hurtBox') and area.get_parent() == player:
		takeDamage(area.get_parent().damage)

func takeDamage(_damage : float) -> void:
	vida -= _damage
	if vida < 0:
		queue_free()
