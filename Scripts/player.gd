extends CharacterBody2D
class_name Player

var directionLast : Vector2 = Vector2.ZERO
@onready var sprite : AnimatedSprite2D = $sprite
var speed : float = 300.0
var vida : float = 300.0
var damage : float = 50.0

func _physics_process(delta: float) -> void:
	var direction : Vector2 = Vector2.ZERO
	
	var moving : bool = false
	
	sprite.flip_h = false
	
	if Input.is_action_pressed("Down"):
		direction.y = 1
		moving = true
		sprite.play("runDown")
	
	elif Input.is_action_pressed("Up"):
		direction.y = -1
		moving = true
		sprite.play("runUp")
		
	if Input.is_action_pressed("Right"):
		direction.x = 1
		moving = true
		sprite.play("runX")
	
	elif Input.is_action_pressed("Left"):
		direction.x = -1
		moving = true
		sprite.play("runX")
		sprite.flip_h = true
	
	if moving:
		velocity = direction * speed
		directionLast = direction
	else:
		velocity = Vector2.ZERO
		if directionLast.x == 1:
			sprite.play("idleX")
		elif directionLast.x == -1:
			sprite.play("idleX")
			sprite.flip_h = true
		elif directionLast.y == 1:
			sprite.play("idleDown")
		else:
			sprite.play("idleUp")
	
	move_and_slide()
	
	

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group('hurtBox') and area.get_parent() is Enemy:
		takeDamage(area.get_parent().damage)

func takeDamage(_damage : float) -> void:
	vida -= _damage
	if vida < 0:
		queue_free()
