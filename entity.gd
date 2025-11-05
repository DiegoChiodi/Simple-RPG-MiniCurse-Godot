extends CharacterBody2D
class_name BaseEntity

var impulse := Vector2.ZERO
var speed : float = 300.0
var vida : float = 100.0
var damage : float = 50.0
var direction := Vector2.ZERO
var sprite : AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	impulse = impulse.lerp(Vector2.ZERO,0.1)
	setDirection()
	setVelocity()
	move_and_slide()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if isRival(area):
		takeDamage(area.get_parent())

func isRival (area : Area2D) -> bool:
	return area.is_in_group('hurtBox')
	
func takeDamage(attacker : BaseEntity) -> void:
	vida -= attacker.damage
	impulse = (position - attacker.position).normalized()
	if vida < 0:
		queue_free()

func setDirection() -> void:
	direction = Vector2.ZERO


func animation(dir : Vector2) -> void:
	
	if abs(dir.x) > abs(dir.y):
		sprite.play("idleX")
		sprite.flip_h = dir.x < 0  # Flip apenas no X
	else:
		if dir.y < 0:
			sprite.play("idleUp")
		else: 
			sprite.play("idleDown")

func setVelocity() -> void:
	velocity = direction * speed + impulse * 200 * 3
